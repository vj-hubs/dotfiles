#!/usr/bin/env bash
set -euo pipefail

# Replaces GitHub org/owner references in GitHub Actions YAML files.
#
# Usage examples:
#   OLD_ORG=old_org NEW_ORG=new_org replace-org-references.sh .
#   BRANCH_NAME=chore/migrate-workflows-org replace-org-references.sh ../some-repo
#   INCLUDE_ALL_YAML=1 replace-org-references.sh path/to/repo
#   DRY_RUN=1 replace-org-references.sh .

REPO_PATH="${1:-.}"
if [[ "${REPO_PATH}" == "-h" || "${REPO_PATH}" == "--help" ]]; then
  cat <<'EOF'
Usage: replace-org-references.sh [REPO_PATH]

Replaces GitHub org/owner references in GitHub Actions YAML files in a git repo.

Arguments:
  REPO_PATH   Path to the repository (relative is fine). Defaults to '.'

Environment variables:
  OLD_ORG          Defaults to 'old_org'
  NEW_ORG          Defaults to 'new_org'
  BRANCH_NAME      Defaults to 'chore/replace-org-<OLD>-with-<NEW>'
  INCLUDE_ALL_YAML Defaults to '0' (set to '1' to scan all tracked *.yml/*.yaml)
  DRY_RUN          Defaults to '0' (set to '1' to only print what would change)
EOF
  exit 0
fi

OLD_ORG="${OLD_ORG:-old_org}"
NEW_ORG="${NEW_ORG:-new_org}"
BRANCH_NAME="${BRANCH_NAME:-chore/replace-${OLD_ORG}-with-${NEW_ORG}}"

# By default, only touch common GitHub Actions YAML locations.
# Set INCLUDE_ALL_YAML=1 to scan all tracked *.yml/*.yaml files in the repo.
INCLUDE_ALL_YAML="${INCLUDE_ALL_YAML:-0}"

# Set DRY_RUN=1 to only print the files that would change.
DRY_RUN="${DRY_RUN:-0}"

cd "${REPO_PATH}"
cd "$(git rev-parse --show-toplevel)"

if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "Refusing to run: working tree has uncommitted changes."
  echo "Commit/stash first, or run in a clean checkout."
  exit 1
fi

if git show-ref --verify --quiet "refs/heads/${BRANCH_NAME}"; then
  echo "Local branch already exists: ${BRANCH_NAME}"
  echo "Delete it or set BRANCH_NAME to something else."
  exit 1
fi

git switch -c "${BRANCH_NAME}"

list_target_files() {
  if [[ "${INCLUDE_ALL_YAML}" == "1" ]]; then
    git ls-files '*.yml' '*.yaml'
    return 0
  fi

  # Typical locations for GitHub Actions workflows and composite actions.
  git ls-files \
    | grep -E '^\.(github/(workflows|actions)/.*\.(yml|yaml))$' \
    || true
}

mapfile -t FILES < <(list_target_files)

if [[ "${#FILES[@]}" -eq 0 ]]; then
  echo "No target YAML files found to scan."
  exit 0
fi

mapfile -t MATCHING_FILES < <(printf '%s\n' "${FILES[@]}" | xargs -r git grep -l --fixed-strings "${OLD_ORG}/" || true)

if [[ "${#MATCHING_FILES[@]}" -eq 0 ]]; then
  echo "No matches found for '${OLD_ORG}/' in target YAML files."
  exit 0
fi

echo "Found ${#MATCHING_FILES[@]} file(s) containing '${OLD_ORG}/':"
printf ' - %s\n' "${MATCHING_FILES[@]}"

if [[ "${DRY_RUN}" == "1" ]]; then
  echo "DRY_RUN=1 set; not modifying files."
  exit 0
fi

# Perform in-place replacement of literal "<OLD_ORG>/" -> "<NEW_ORG>/"
perl -pi -e "s/\Q${OLD_ORG}\E\//${NEW_ORG}\//g" "${MATCHING_FILES[@]}"

echo
echo "Done. Review changes:"
git status --porcelain
echo
echo "Next steps:"
echo "  - Inspect diffs: git diff"
echo "  - Commit:        git commit -am \"chore: migrate ${OLD_ORG} -> ${NEW_ORG} in actions\""
