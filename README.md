# my-bootstrap

Human- (or agent-) readable instructions for bootstrapping a new research server.

The instructions in this repository are intended to remain inspectable and
adaptable when hardware, operating systems, or site-specific requirements
differ between servers.

## Quick start

```sh
git clone https://github.com/SyphonArch/my-bootstrap.git
cd my-bootstrap
curl -fsSL https://chatgpt.com/codex/install.sh | sh
codex
```

After Codex starts, select a mode and follow [`BOOTSTRAP.md`](BOOTSTRAP.md):

- `bootstrap`: Set up a new or intentionally clean environment.
- `reconcile`: Bring an existing environment into alignment.
- `patch`: Apply or reconcile only requested sections or subsections.

## Contents

- [`AGENTS.md`](AGENTS.md): Interaction, confirmation, safety, and tmux rules.
- [`BOOTSTRAP.md`](BOOTSTRAP.md): The ordered setup procedure.
- [`sources/`](sources): Configuration sources and Slurm helper scripts to
  inspect, resolve, and apply during setup.

Existing installations and configuration are inspected first. Changes must be
shown and confirmed, configuration must be applied non-destructively, and
unresolved `BOOTSTRAP_RESOLVE` regions must not be installed.

Do not add credentials to this repository. Authentication steps are performed
by the user and must not expose secrets in chat, commands, logs, or configuration
output.
