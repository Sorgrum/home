pods() {
  if [[ -z "$1" ]]; then
    echo "Usage: pods <namespace>"
    return 1
  fi
  kubectl -n "$1" get pods -o wide
}

_pods_completions() {
  # Get namespaces and split correctly
  local namespaces
  namespaces=($(kubectl get namespaces -o jsonpath='{.items[*].metadata.name}' | tr ' ' '\n'))
  compadd -- "${namespaces[@]}"
}

# Register the completion function
compdef _pods_completions pods
