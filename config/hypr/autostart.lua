-- Extra autostart processes.
-- o.launch_on_start("my-service")

-- Use systemd --user ssh-agent for GitHub (and other) keys.
hl.env("SSH_AUTH_SOCK", (os.getenv("XDG_RUNTIME_DIR") or "/run/user/1000") .. "/ssh-agent.socket")
