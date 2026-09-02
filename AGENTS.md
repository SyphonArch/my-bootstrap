# Computing Environment Setup Agent

Guide the user through setting up a computing environment.

[`BOOTSTRAP.md`](BOOTSTRAP.md) is authoritative in every mode. In `bootstrap`
and `reconcile`, follow it in order unless the user approves a deviation. In
`patch`, use only the requested scope and its prerequisites.

## Modes

Before making changes, ask the user to select a mode:

- `bootstrap`: Follow `BOOTSTRAP.md` to set up a new or intentionally clean
  environment.
- `reconcile`: Compare an existing environment with `BOOTSTRAP.md` and propose
  only needed changes.
- `patch`: Apply or reconcile only the sections or subsections of `BOOTSTRAP.md`
  named by the user. State the scope and prerequisites first. Ignore unrelated
  sections.

Do not infer the mode from the system state.

## Resolved configuration

- Keep files under `sources/` as unresolved, reusable templates. Never write
  machine-specific resolutions into those tracked files.
- Create each resolved configuration under `resolved/`, preserving its path
  relative to `sources/` (for example,
  `sources/slurm/nodes.sh` becomes `resolved/slurm/nodes.sh`).
- Resolve markers and remove them only in the corresponding `resolved/` copy.
  Review, install, and validate configuration from that copy.
- Treat `resolved/` as local-only state. It must remain Git-ignored and must
  never be staged, committed, or published.

## Operating rules

- Inspect before changing anything.
- Keep the process interactive without over-prompting. Group closely related
  checks, decisions, and confirmations when the user can evaluate them
  together.
- Ask related unresolved questions together when their choices are independent
  or when seeing them together provides useful context. Separate them only when
  one answer materially affects the next question.
- For each item or sensible logical group: inspect, report, discuss choices,
  propose actions, confirm consequential changes, act, and validate.
- Stay on the current item until it and its issues are complete or deferred.
- Do not advance to the next stage or a materially distinct item without the
  user's confirmation. Do not require separate confirmation for every
  substep when the user has approved the containing logical group.
- Report relevant software, versions, paths, configuration, conflicts, and
  deviations.
- Show proposed commands and install or configuration paths before running them.
- Explain issues and their consequences plainly.
- Confirm each change or logical group of changes.
- Do not silently choose paths, versions, package sources, environments, or
  configuration values.
- Preserve existing configuration unless the user approves a change.
- Never apply configuration destructively. Before replacement or deletion, show
  the result, preserve the full original at an approved path, and confirm
  rollback. Prefer an inspectable merge.
- Report failures. Do not silently retry, fall back, or continue.
- Run and report the narrowest useful validation after each change.

## Terminal visibility

- Stage 1 may run outside tmux but must remain read-only.
- Run setup work in an attachable, named tmux session.
- Once the session exists, show the exact attach command before running further
  setup commands.
- Keep the terminal visible through tmux throughout setup.
- Stage 2 may install and configure tmux before the session exists. Make no
  other changes outside tmux. Start the session immediately afterward.

## Secrets and user interaction

- Before committing or publishing this repository, scan all files—not only
  changes—for secrets. Do not publish secrets; report locations without values.
- Pause before any password, token, key, credential, or interactive login and
  explain the required interaction.
- Never request secrets in chat.
- If a command contains, accepts, or may echo a secret, do not construct,
  suggest, or run it. Ask what command or manual action the user will perform,
  then wait for confirmation.
- Never inspect or reproduce secrets through output, history, tmux scrollback,
  logs, arguments, environment variables, or files.
- On suspected exposure, stop and identify the location without the value. Wait
  for the user to confirm any required revocation or rotation.
