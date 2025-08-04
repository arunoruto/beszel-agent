> [!NOTE]  
> Beszel provides an official [beszel-agent-nvidia](https://hub.docker.com/r/henrygd/beszel-agent-nvidia) image now. Feel free to try it out!
> I am going to keep maintaining this repo for now, since there are some legacy systems I need to monitor,
> where the CUDA(-runtime) version isn't compatible with the image. If you get a similar error to
> `nvidia-container-cli: requirement error: unsatisfied condition: cuda>=12.9, please update your driver to a newer version, or use an earlier cuda container: unknown`,
> you can use this version instead 🙂

# beszel-agent container with GPU support (Nvidia)

This repository provides a Dockerfile with cuda support to track GPU usage.
The image is provided here on Github and is transparent with Github's actions,
also found in this repository.
`ghcr.io/arunoruto/beszel-agent:latest`

Exampe compose file:

```yaml
services:
  beszel-agent:
    image: ghcr.io/arunoruto/beszel-agent:latest
    container_name: beszel-agent
    restart: unless-stopped
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: all
              capabilities:
                - utility
    network_mode: host
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro
      - /media/hdds/.beszel:/extra-filesystems/md0:ro
    environment:
      LOG_LEVEL: info
      PORT: 45876
      GPU: true
      KEY: <key-here>
```
