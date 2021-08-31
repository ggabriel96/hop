# hop

Some Ansible roles and playbooks to help me distro-hop :stuck_out_tongue_winking_eye:

This has been tested **only manually** and on **Fedora 34**.
So feel free to use it, but at your own risk.
**Always review code you find online before running it**.

## Quickstart

1. Install Ansible and, _optionally_, [Ansible Runner](https://ansible-runner.readthedocs.io/):

    ```sh
    pip install ansible ansible-runner
    ```

1. Install needed Ansible collections:

    ```sh
    ansible-galaxy collection install ansible.posix community.crypto community.general
    ```

1. Clone this repository.
    I will refer to the destination directory of the cloned repo as `${HOP_DIR}`.
    You can set this variable for your current shell so you can directly copy and paste the commands provided here:

    ```sh
    export HOP_DIR=<the actual directory here>  # bash
    set -gx HOP_DIR <the actual directory here>  # fish
    ```

1. Setup your playbook inside `${HOP_DIR}/project/`.
    The playbook I use is [`project/fedora.yml`](project/fedora.yml), so I will use it in the command examples.
    Replace it with your own if not editing it directly.
    The [Roles and variables](#roles-and-variables) section below describes the available roles and its variables.

1. Run with either `ansible-playbook` (it comes with Ansible) or `ansible-runner`.
    Prefer `ansible-runner` when running the playbook multiple times, e.g. when experimenting,
        since it will automatically fill in your `sudo` password.

    - With `ansible-playbook`:

        ```sh
        ansible-playbook -K ${HOP_DIR}/project/fedora.yml
        ```

    - With `ansible-runner`:

        1. Tell your `sudo` password.
            Fill it in `${HOP_DIR}/env/passwords` (replacing `your sudo password`; you can undo the changes when done).

        1. Run:

            ```sh
            ansible-runner run -p fedora.yml ${HOP_DIR}
            ```

## Roles and variables

Roles are what provide the automation of tasks.
The majority of them have variables which allow the customization of what they do.
They are specified in two files inside every role directory (`project/roles/<role>/`):

- `defaults/main.yml` (this is the main one)
- `vars/main.yml`

Below is a list of the available roles and their important variables.
Refer to [`project/fedora.yml`](project/fedora.yml) for usage examples.

<details>
<summary>conda</summary>

Install [miniconda](https://docs.conda.io/en/latest/miniconda.html) using the official [Linux installer](https://conda.io/projects/conda/en/latest/user-guide/install/linux.html).

Variables:

- `install_dir`: installation directory. Defaults to `~/miniconda3/`

</details>

<details>
<summary>debian</summary>

Install packages using `apt`.

Variables:

- `cleanup`: whether to run `autoclean` and `autoremove` at the end. Defaults to `yes`
- `system_packages`: list of packages to install. Defaults to `[]` (nothing)
- `update_all`: whether to upgrade every installed package as first step. Defaults to `yes`

</details>

<details>
<summary>elementary os</summary>

Just delegates to the `debian` role.
Refer to its description.

</details>

<details>
<summary>files</summary>

Download remote files or create links to local files.

Variables:

- `download`: list of mappings describing files that should be downloaded.
    The available keys are `url` and `dest`. Defaults to `[]` (nothing)
- `link`: list of mappings describing links that should be created.
    The available keys are `src` and `dest`. Defaults to `[]` (nothing)

In any case, the role will perform a backup of `dest` before replacing it.
The backup will be placed at `<dest>.backup-<datetime>`,
    where `<datetime>` is a simplified version of the current date and time in ISO 8601 format.
Note that the backup will end up _beside_ `dest` if it's a file or _inside_ it if it's a directory.
Also, backups of already backed up directories will contain the older backups.

</details>

<details>
<summary>flatpak</summary>

Configure Flatpak and install packages.

Variables:

- `add_flathub`: whether to add Flathub repository. Defaults to `yes`
- `packages`: list of packages to install. Defaults to `[]` (nothing)

</details>

<details>
<summary>flutter</summary>

Install [Flutter via snap](https://flutter.dev/docs/get-started/install/linux).

Has no variables.

</details>

<details>
<summary>fonts</summary>

Shortcut to install some fonts I like (Fira Code, Google's Noto, and JetBrains Mono).

Variables:

- `fonts_target_dir`: fonts installation directory. Defaults to `~/.local/share/fonts/`
- `jetbrains_mono_version`: version of the JetBrains Mono font to install. Defaults to `2.225`.
    Choose a tag from the [releases page](https://github.com/JetBrains/JetBrainsMono/releases)

</details>

<details>
<summary>google-cloud-sdk</summary>

Install Google Cloud SDK using the official [Linux installer](https://cloud.google.com/sdk/docs/install).
It's also possible to install it via the `snap` role.

Variables:

- `cloudsdk_install_dir`: installation _base_ directory. Defaults to `~/`
    (installer will create a dedicated directory in here)

</details>

<details>
<summary>install</summary>

Generic role to install system packages that share the name in Debian-based and RedHat-based distros.

Variables:

- `system`: list of packages to install. Defaults to `[]` (nothing)

</details>

<details>
<summary>redhat</summary>

Install packages using `dnf`.

Variables:

- `cleanup`: whether to run and `autoremove` at the end. Defaults to `yes`
- `system_packages`: list of packages to install. Defaults to `[]` (nothing)
- `update_all`: whether to upgrade every installed package as first step. Defaults to `yes`

</details>

<details>
<summary>rust</summary>

Install [Rust](https://www.rust-lang.org/) using the official [Linux installer](https://www.rust-lang.org/tools/install).

Has no variables.
Currently, accepts the default settings from the install script and **does not modify `PATH`**.

</details>

<details>
<summary>snap</summary>

Configure Snap and install packages.

Variables:

- `channel`: channel to use to install the packages. Defaults to `stable`
- `classic_packages`:  list of packages _requiring_ classic confinement to install. Defaults to `[]` (nothing)
- `packages`:  list of packages to install. Defaults to `[]` (nothing)

</details>

<details>
<summary>sysctl</summary>

Configure `sysctl` entries.

Variables:

- `sysctl_entries`: mapping of entries and its values to set. Defaults to `{}` (nothing)
- `sysctl_reload`: whether to reload `sysctl` after each entry. Defaults to `yes`

</details>

<details>
<summary>user</summary>

General user-related settings.

Variables:

- `git_user_email`: email to globally set to git's `user.email`. Has no defaults and skips it if not provided
- `git_user_name`: name to globally set to git's `user.name`. Has no defaults and skips it if not provided
- `ssh_keys`: list of names of SSH keys to create, relative to `ssh_keys_dir`. Defaults to `[]` (nothing)
- `ssh_keys_comment`: comment to add to every created key.
    Defaults to the value of the `git_user_email` variable or no comment if that's not provided
- `ssh_keys_dir`: directory in which to create the keys. Defaults to `~/.ssh`
- `ssh_keys_type`: type of keys to create. Defaults to `ed25519`
- `user_login_shell`: name of login shell to set for current user (separately installed). Defaults to `bash`

</details>

<details>
<summary>zoom</summary>

Download the [official Zoom client](https://zoom.us/download) and install it.

Has no variables.

</details>
