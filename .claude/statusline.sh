#!/bin/bash
# Aknakos Framework - Adaptive Statusline
# Shows contextual workflow info with emoji + 3-letter prefix

# Color codes
CYAN='\033[1;36m'
WHITE='\033[1;37m'
DIM='\033[2;37m'
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
RED='\033[1;31m'
BLUE='\033[1;34m'
BOLD='\033[1m'
RESET='\033[0m'

# Auto-detect project directory (script is in .claude/, project root is parent)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Get workflow state file path
WORKFLOW_FILE="${PROJECT_ROOT}/.aknakos/state/workflow.yaml"

# Check if workflow file exists
if [[ ! -f "$WORKFLOW_FILE" ]]; then
    echo -e "${RED}⚠️  ERR${RESET} | No workflow.yaml found"
    exit 0
fi

# Use local yq binary if available, otherwise check system
YQ_BIN="${PROJECT_ROOT}/.claude/yq"
if [[ ! -f "$YQ_BIN" ]]; then
    # Fall back to system yq
    if ! command -v yq &> /dev/null; then
        echo -e "${RED}⚠️  ERR${RESET} | yq not installed"
        exit 0
    fi
    YQ_BIN="yq"
fi

# Read current phase
PHASE=$($YQ_BIN e '.current_phase' "$WORKFLOW_FILE")

# Count products
PRODUCT_COUNT=$($YQ_BIN e '.products | length' "$WORKFLOW_FILE")

# Get first product (if exists)
PRODUCT_NAME=""
if [[ $PRODUCT_COUNT -gt 0 ]]; then
    PRODUCT_NAME=$($YQ_BIN e '.products | keys | .[0]' "$WORKFLOW_FILE")
fi

# Determine context and build statusline
case "$PHASE" in
    "vision"|"mission_created")
        # Strategic phase - no product yet
        echo -e "${CYAN}📋 STR${RESET} | Vision → Mission | No active product"
        ;;

    "project_brief_created"|"architecture_created"|"ux_flow_created"|"prd")
        # Strategic phase - with product
        if [[ -n "$PRODUCT_NAME" ]]; then
            # Show which strategic docs exist
            MISSION=$($YQ_BIN e ".products.\"$PRODUCT_NAME\".mission_created" "$WORKFLOW_FILE")
            BRIEF=$($YQ_BIN e ".products.\"$PRODUCT_NAME\".project_brief_created" "$WORKFLOW_FILE")
            ARCH=$($YQ_BIN e ".products.\"$PRODUCT_NAME\".architecture_created" "$WORKFLOW_FILE")
            UX=$($YQ_BIN e ".products.\"$PRODUCT_NAME\".ux_flow_created" "$WORKFLOW_FILE")

            DOCS=""
            [[ "$MISSION" == "true" ]] && DOCS="${DOCS}Mission✓ "
            [[ "$BRIEF" == "true" ]] && DOCS="${DOCS}Brief✓ "
            [[ "$ARCH" == "true" ]] && DOCS="${DOCS}Arch✓ "
            [[ "$UX" == "true" ]] && DOCS="${DOCS}UX✓ "

            echo -e "${CYAN}📋 STR${RESET} | ${WHITE}${PRODUCT_NAME}${RESET} | ${DOCS}→ PRD"
        else
            echo -e "${CYAN}📋 STR${RESET} | $PHASE | No product"
        fi
        ;;

    "epic_breakdown"|"validation_complete")
        # Epic breakdown phase
        if [[ -n "$PRODUCT_NAME" ]]; then
            EPIC_COUNT=$($YQ_BIN e ".products.\"$PRODUCT_NAME\".epics | length" "$WORKFLOW_FILE" 2>/dev/null || echo "0")
            VALIDATED=$($YQ_BIN e ".products.\"$PRODUCT_NAME\".validation.status" "$WORKFLOW_FILE" 2>/dev/null || echo "PENDING")

            if [[ "$PHASE" == "validation_complete" && "$VALIDATED" == "PASS" ]]; then
                echo -e "${CYAN}📋 STR${RESET} | ${WHITE}${PRODUCT_NAME}${RESET} | ${GREEN}Validation: PASS${RESET} | ${EPIC_COUNT} epics ready"
            elif [[ "$VALIDATED" == "CONCERNS" ]]; then
                echo -e "${CYAN}📋 STR${RESET} | ${WHITE}${PRODUCT_NAME}${RESET} | ${YELLOW}Validation: CONCERNS${RESET} | ${EPIC_COUNT} epics"
            elif [[ "$VALIDATED" == "FAIL" ]]; then
                echo -e "${CYAN}📋 STR${RESET} | ${WHITE}${PRODUCT_NAME}${RESET} | ${RED}Validation: FAIL${RESET} | ${EPIC_COUNT} epics"
            else
                echo -e "${CYAN}📋 STR${RESET} | ${WHITE}${PRODUCT_NAME}${RESET} | Epic breakdown | ${EPIC_COUNT} epics"
            fi
        else
            echo -e "${CYAN}📋 STR${RESET} | $PHASE"
        fi
        ;;

    "planning_mode")
        # Planning mode
        if [[ -n "$PRODUCT_NAME" ]]; then
            EPIC=$($YQ_BIN e ".products.\"$PRODUCT_NAME\".current_work.epic" "$WORKFLOW_FILE" 2>/dev/null)

            if [[ -n "$EPIC" && "$EPIC" != "null" ]]; then
                # Get epic details
                PRIORITY=$($YQ_BIN e ".products.\"$PRODUCT_NAME\".epics[] | select(.name == \"$EPIC\") | .priority" "$WORKFLOW_FILE" 2>/dev/null || echo "")
                COMPLEXITY=$($YQ_BIN e ".products.\"$PRODUCT_NAME\".epics[] | select(.name == \"$EPIC\") | .implementation_complexity" "$WORKFLOW_FILE" 2>/dev/null || echo "")

                # Color priority
                PRIORITY_COLOR="$DIM"
                if [[ "$PRIORITY" == "P0" || "$PRIORITY" == "P1" ]]; then
                    PRIORITY_COLOR="$YELLOW"
                fi

                if [[ -n "$COMPLEXITY" && "$COMPLEXITY" != "null" ]]; then
                    echo -e "${CYAN}📊 PLN${RESET} | ${WHITE}${PRODUCT_NAME}${RESET} | ${WHITE}${EPIC}${RESET} [${PRIORITY_COLOR}${PRIORITY}${RESET}:${COMPLEXITY}] | Breaking down stories"
                else
                    echo -e "${CYAN}📊 PLN${RESET} | ${WHITE}${PRODUCT_NAME}${RESET} | ${WHITE}${EPIC}${RESET} | Breaking down stories"
                fi
            else
                echo -e "${CYAN}📊 PLN${RESET} | ${WHITE}${PRODUCT_NAME}${RESET} | Planning mode"
            fi
        else
            echo -e "${CYAN}📊 PLN${RESET} | Planning mode"
        fi
        ;;

    "tdd_tests_written"|"tdd_test_review"|"tdd_implementation"|"tdd_refactor")
        # Epic work - TDD cycle
        if [[ -n "$PRODUCT_NAME" ]]; then
            EPIC=$($YQ_BIN e ".products.\"$PRODUCT_NAME\".current_work.epic" "$WORKFLOW_FILE" 2>/dev/null)

            if [[ -n "$EPIC" && "$EPIC" != "null" ]]; then
                # Get epic details
                PRIORITY=$($YQ_BIN e ".products.\"$PRODUCT_NAME\".epics[] | select(.name == \"$EPIC\") | .priority" "$WORKFLOW_FILE" 2>/dev/null || echo "")
                COMPLEXITY=$($YQ_BIN e ".products.\"$PRODUCT_NAME\".epics[] | select(.name == \"$EPIC\") | .implementation_complexity" "$WORKFLOW_FILE" 2>/dev/null || echo "")

                # TDD state
                TDD_STATE=""
                TDD_COLOR="$WHITE"
                case "$PHASE" in
                    "tdd_tests_written"|"tdd_test_review")
                        TDD_STATE="RED"
                        TDD_COLOR="$RED"
                        ;;
                    "tdd_implementation")
                        TESTS_PASSING=$($YQ_BIN e ".products.\"$PRODUCT_NAME\".epics[] | select(.name == \"$EPIC\") | .tdd.tests_passing" "$WORKFLOW_FILE" 2>/dev/null || echo "false")
                        if [[ "$TESTS_PASSING" == "true" ]]; then
                            TDD_STATE="GREEN"
                            TDD_COLOR="$GREEN"
                        else
                            TDD_STATE="RED"
                            TDD_COLOR="$RED"
                        fi
                        ;;
                    "tdd_refactor")
                        TDD_STATE="REFACTOR"
                        TDD_COLOR="$BLUE"
                        ;;
                esac

                # Color priority
                PRIORITY_COLOR="$DIM"
                if [[ "$PRIORITY" == "P0" || "$PRIORITY" == "P1" ]]; then
                    PRIORITY_COLOR="$YELLOW"
                fi

                # Adaptive verbosity based on complexity
                if [[ -n "$COMPLEXITY" && "$COMPLEXITY" != "null" ]]; then
                    COMPLEXITY_NUM=$COMPLEXITY

                    # Simple (1-3): Compact
                    if [[ $COMPLEXITY_NUM -le 3 ]]; then
                        echo -e "${CYAN}🎯 EPC${RESET} | ${WHITE}${PRODUCT_NAME}${RESET} | ${WHITE}${EPIC}${RESET} [${PRIORITY_COLOR}${PRIORITY}${RESET}:${COMPLEXITY}] | TDD:${TDD_COLOR}${TDD_STATE}${RESET}"

                    # Moderate (4-6): Add more context
                    elif [[ $COMPLEXITY_NUM -le 6 ]]; then
                        TESTS_CHANGED=$($YQ_BIN e ".products.\"$PRODUCT_NAME\".epics[] | select(.name == \"$EPIC\") | .tdd.tests_changed_during_implementation" "$WORKFLOW_FILE" 2>/dev/null || echo "false")
                        WARNING=""
                        if [[ "$TESTS_CHANGED" == "true" ]]; then
                            WARNING=" | ${RED}⚠️ Tests changed${RESET}"
                        fi
                        echo -e "${CYAN}🎯 EPC${RESET} | ${WHITE}${PRODUCT_NAME}${RESET} | ${WHITE}${EPIC}${RESET} [${PRIORITY_COLOR}${PRIORITY}${RESET}:${COMPLEXITY}] | TDD:${TDD_COLOR}${TDD_STATE}${RESET}${WARNING}"

                    # Complex (7-9): Full details
                    else
                        TESTS_CHANGED=$($YQ_BIN e ".products.\"$PRODUCT_NAME\".epics[] | select(.name == \"$EPIC\") | .tdd.tests_changed_during_implementation" "$WORKFLOW_FILE" 2>/dev/null || echo "false")

                        # Count reviews if available
                        REVIEW_TOTAL=0
                        REVIEW_PASS=0
                        REVIEW_CONCERNS=0
                        REVIEW_FAIL=0

                        for reviewer in test security architecture quality requirements; do
                            STATUS=$($YQ_BIN e ".products.\"$PRODUCT_NAME\".epics[] | select(.name == \"$EPIC\") | .reviews.$reviewer" "$WORKFLOW_FILE" 2>/dev/null || echo "")
                            if [[ -n "$STATUS" && "$STATUS" != "null" && "$STATUS" != "PENDING" ]]; then
                                REVIEW_TOTAL=$((REVIEW_TOTAL + 1))
                                case "$STATUS" in
                                    "PASS") REVIEW_PASS=$((REVIEW_PASS + 1)) ;;
                                    "CONCERNS") REVIEW_CONCERNS=$((REVIEW_CONCERNS + 1)) ;;
                                    "FAIL") REVIEW_FAIL=$((REVIEW_FAIL + 1)) ;;
                                esac
                            fi
                        done

                        WARNING=""
                        if [[ "$TESTS_CHANGED" == "true" ]]; then
                            WARNING=" | ${RED}⚠️ Tests changed${RESET}"
                        fi

                        REVIEW_INFO=""
                        if [[ $REVIEW_TOTAL -gt 0 ]]; then
                            REVIEW_INFO=" | Reviews:${REVIEW_PASS}✅"
                            [[ $REVIEW_CONCERNS -gt 0 ]] && REVIEW_INFO="${REVIEW_INFO} ${REVIEW_CONCERNS}⚠️"
                            [[ $REVIEW_FAIL -gt 0 ]] && REVIEW_INFO="${REVIEW_INFO} ${REVIEW_FAIL}❌"
                        fi

                        echo -e "${CYAN}🎯 EPC${RESET} | ${BOLD}${WHITE}${PRODUCT_NAME}${RESET} | ${BOLD}${WHITE}${EPIC}${RESET} [${PRIORITY_COLOR}${PRIORITY}${RESET}:${BOLD}${COMPLEXITY}${RESET}] | TDD:${TDD_COLOR}${TDD_STATE}${RESET}${REVIEW_INFO}${WARNING}"
                    fi
                else
                    echo -e "${CYAN}🎯 EPC${RESET} | ${WHITE}${PRODUCT_NAME}${RESET} | ${WHITE}${EPIC}${RESET} | TDD:${TDD_COLOR}${TDD_STATE}${RESET}"
                fi
            else
                echo -e "${CYAN}🎯 EPC${RESET} | ${WHITE}${PRODUCT_NAME}${RESET} | $PHASE"
            fi
        else
            echo -e "${CYAN}🎯 EPC${RESET} | $PHASE"
        fi
        ;;

    "review")
        # Review phase
        if [[ -n "$PRODUCT_NAME" ]]; then
            EPIC=$($YQ_BIN e ".products.\"$PRODUCT_NAME\".current_work.epic" "$WORKFLOW_FILE" 2>/dev/null)

            if [[ -n "$EPIC" && "$EPIC" != "null" ]]; then
                # Count review statuses
                REVIEW_PASS=0
                REVIEW_CONCERNS=0
                REVIEW_FAIL=0
                REVIEW_PENDING=0

                for reviewer in test security architecture quality requirements; do
                    STATUS=$($YQ_BIN e ".products.\"$PRODUCT_NAME\".epics[] | select(.name == \"$EPIC\") | .reviews.$reviewer" "$WORKFLOW_FILE" 2>/dev/null || echo "PENDING")
                    case "$STATUS" in
                        "PASS") REVIEW_PASS=$((REVIEW_PASS + 1)) ;;
                        "CONCERNS") REVIEW_CONCERNS=$((REVIEW_CONCERNS + 1)) ;;
                        "FAIL") REVIEW_FAIL=$((REVIEW_FAIL + 1)) ;;
                        "PENDING"|"null") REVIEW_PENDING=$((REVIEW_PENDING + 1)) ;;
                    esac
                done

                META=$($YQ_BIN e ".products.\"$PRODUCT_NAME\".epics[] | select(.name == \"$EPIC\") | .reviews.meta_review" "$WORKFLOW_FILE" 2>/dev/null || echo "PENDING")

                REVIEW_STATUS="${REVIEW_PASS}${GREEN}✅${RESET}"
                [[ $REVIEW_CONCERNS -gt 0 ]] && REVIEW_STATUS="${REVIEW_STATUS} ${REVIEW_CONCERNS}${YELLOW}⚠️${RESET}"
                [[ $REVIEW_FAIL -gt 0 ]] && REVIEW_STATUS="${REVIEW_STATUS} ${REVIEW_FAIL}${RED}❌${RESET}"
                [[ $REVIEW_PENDING -gt 0 ]] && REVIEW_STATUS="${REVIEW_STATUS} ${REVIEW_PENDING}⏳"

                META_STATUS=""
                case "$META" in
                    "PASS") META_STATUS="${GREEN}PASS${RESET}" ;;
                    "CONCERNS") META_STATUS="${YELLOW}CONCERNS${RESET}" ;;
                    "FAIL") META_STATUS="${RED}FAIL${RESET}" ;;
                    *) META_STATUS="${DIM}PENDING${RESET}" ;;
                esac

                echo -e "${CYAN}🔍 REV${RESET} | ${WHITE}${EPIC}${RESET} | ${REVIEW_STATUS} | Meta:${META_STATUS}"
            else
                echo -e "${CYAN}🔍 REV${RESET} | ${WHITE}${PRODUCT_NAME}${RESET} | Review phase"
            fi
        else
            echo -e "${CYAN}🔍 REV${RESET} | Review phase"
        fi
        ;;

    "epic_complete")
        # Epic completed
        if [[ -n "$PRODUCT_NAME" ]]; then
            LAST_EPIC=$($YQ_BIN e ".products.\"$PRODUCT_NAME\".epics[] | select(.status == \"complete\") | .name" "$WORKFLOW_FILE" 2>/dev/null | tail -1)

            if [[ -n "$LAST_EPIC" && "$LAST_EPIC" != "null" ]]; then
                echo -e "${CYAN}✅ CPL${RESET} | ${GREEN}${LAST_EPIC}${RESET} | Complete | Ready for next epic"
            else
                echo -e "${CYAN}✅ CPL${RESET} | ${WHITE}${PRODUCT_NAME}${RESET} | Epic complete"
            fi
        else
            echo -e "${CYAN}✅ CPL${RESET} | Epic complete"
        fi
        ;;

    *)
        # Check for parked work
        if [[ -n "$PRODUCT_NAME" ]]; then
            CURRENT_EPIC=$($YQ_BIN e ".products.\"$PRODUCT_NAME\".current_work.epic" "$WORKFLOW_FILE" 2>/dev/null)
            PARKED_COUNT=$($YQ_BIN e ".products.\"$PRODUCT_NAME\".parked_work | length" "$WORKFLOW_FILE" 2>/dev/null || echo "0")

            # Count backlog epics
            BACKLOG_COUNT=$($YQ_BIN e ".products.\"$PRODUCT_NAME\".epics[] | select(.status == \"backlog\") | .name" "$WORKFLOW_FILE" 2>/dev/null | wc -l || echo "0")
            BACKLOG_COUNT=$(echo "$BACKLOG_COUNT" | xargs)  # Trim whitespace

            if [[ -z "$CURRENT_EPIC" || "$CURRENT_EPIC" == "null" ]]; then
                if [[ $PARKED_COUNT -gt 0 ]]; then
                    echo -e "${CYAN}⏸️  PRK${RESET} | ${WHITE}${PRODUCT_NAME}${RESET} | ${PARKED_COUNT} parked | ${BACKLOG_COUNT} backlog"
                else
                    echo -e "${CYAN}⏸️  PRK${RESET} | ${WHITE}${PRODUCT_NAME}${RESET} | No active work | ${BACKLOG_COUNT} backlog"
                fi
            else
                echo -e "${CYAN}🎯 EPC${RESET} | ${WHITE}${PRODUCT_NAME}${RESET} | ${CURRENT_EPIC} | $PHASE"
            fi
        else
            echo -e "${CYAN}📋 STR${RESET} | $PHASE"
        fi
        ;;
esac
