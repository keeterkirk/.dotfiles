# Claude agent runner — invoke from any project directory
# Usage: agent <agent-name> [prompt]
# The sniffer auto-detects work/home profile
function agent() {
  ~/dev/claude-agents/scripts/run-agent.sh "$@"
}
