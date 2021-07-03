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

1. Run with either `ansible-playbook` or `ansible-runner`.
    Prefer `ansible-runner` when running the playbook multiple times, e.g. when experimenting,
        since it will automatically fill in your `sudo` password.

    - With `ansible-playbook`:

        ```sh
        ansible-playbook -K ${HOP_DIR}/project/fedora.yml
        ```

    - `ansible-runner`:

        1. Tell your `sudo` password.
            Fill it in `${HOP_DIR}/env/passwords` (replacing `your sudo password`; you can undo the changes when done).

        1. Run:

            ```sh
            ansible-runner run -p fedora.yml ${HOP_DIR}
            ```
