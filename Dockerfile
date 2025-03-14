# Based on https://github.com/henrygd/beszel/issues/262#issuecomment-2566388110

FROM ghcr.io/henrygd/beszel/beszel-agent:latest as beszel

# Stage 2: Final image with NVIDIA Toolkit
FROM nvidia/cuda:12.4.0-base-ubuntu22.04

# Copy the agent binary from the Beszel base image
COPY --from=beszel /agent /agent

# Install NVIDIA Toolkit
RUN apt-get update && \
    apt-get install -y --no-install-recommends nvidia-container-toolkit && \
    rm -rf /var/lib/apt/lists/*

# Set the entrypoint
ENTRYPOINT ["/agent"]
