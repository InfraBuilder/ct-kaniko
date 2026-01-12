# Kaniko Docker Image

This Docker image provides a free, open-source implementation of Kaniko, a tool for building container images from a Dockerfile inside a container or Kubernetes cluster without privileged access.


[![Docker Image Size](https://img.shields.io/docker/image-size/infrabuilder/kaniko/latest)](https://hub.docker.com/r/infrabuilder/kaniko)
[![Docker Pulls](https://img.shields.io/docker/pulls/infrabuilder/kaniko)](https://hub.docker.com/r/infrabuilder/kaniko)
[![Docker Image Vulnerabilities](https://img.shields.io/badge/security-scanned-brightgreen)](https://hub.docker.com/r/infrabuilder/kaniko)
[![GitHub Repo](https://img.shields.io/badge/github-repo-blue?logo=github)](https://github.com/infrabuilder/kaniko)
[![CI](https://github.com/infrabuilder/kaniko/actions/workflows/docker-build-push.yml/badge.svg)](https://github.com/infrabuilder/kaniko/actions)
[![Docker Weekly Build](https://img.shields.io/badge/autobuild-weekly-brightgreen)](https://hub.docker.com/r/infrabuilder/kaniko)


## Key Features

- **Free and Open Source**: No charges or licensing fees
- **Based on Wolfi**: Uses the secure, minimal Wolfi Linux distribution
- **Standard Kaniko**: Full compatibility with Kaniko's standard features and flags
- **Container-Native**: Designed to run in containers without privileged access

## Why This Image Exists

After Google archived the Kaniko project, [Chainguard](https://www.chainguard.dev/) took over maintenance ([blog](https://www.chainguard.dev/fr-FR/unchained/fork-yeah-were-bringing-kaniko-back) - [github](https://github.com/chainguard-forks/kaniko)). However, Chainguard's official Kaniko images are not freely available, which creates a barrier for users seeking a cost-free solution.

This image provides a free alternative based on the [Wolfi](https://wolfi.dev/) Linux distribution repository, ensuring that Kaniko remains accessible to the open-source community without any charges.

## Usage Examples

### Basic Example: Building a Docker Image

The most common use case for Kaniko is building Docker images in CI/CD pipelines or Kubernetes clusters without requiring Docker daemon access.

```bash
docker run \
  -v $(pwd):/workspace \
  -v $HOME/.docker/config.json:/kaniko/.docker/config.json:ro \
  your-registry/ct-kaniko:latest \
  --dockerfile=/workspace/Dockerfile \
  --context=/workspace \
  --destination=your-registry/your-image:tag
```

### Kubernetes Example

Here's an example of using this image in a Kubernetes Pod to build and push an image:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: kaniko-build
spec:
  containers:
  - name: kaniko
    image: your-registry/ct-kaniko:latest
    args:
    - --dockerfile=/workspace/Dockerfile
    - --context=/workspace
    - --destination=your-registry/your-image:tag
    volumeMounts:
    - name: workspace
      mountPath: /workspace
    - name: docker-config
      mountPath: /kaniko/.docker
  volumes:
  - name: workspace
    emptyDir: {}
  - name: docker-config
    secret:
      secretName: docker-config
```

### GitLab CI Example

```yaml
build:
  image: your-registry/ct-kaniko:latest
  script:
    - /usr/bin/executor
      --dockerfile=$CI_PROJECT_DIR/Dockerfile
      --context=$CI_PROJECT_DIR
      --destination=$CI_REGISTRY_IMAGE:$CI_COMMIT_TAG
```

## About Wolfi

[Wolfi](https://wolfi.dev/) is a Linux distribution designed specifically for containers and cloud workloads. It's maintained by Chainguard and focuses on security, minimalism, and supply chain security. Wolfi uses a declarative approach to package management and provides a minimal base image that's ideal for containerized applications.

## About Chainguard

[Chainguard](https://www.chainguard.dev/) is a company that specializes in software supply chain security. They maintain several open-source projects and provide security-focused container images. Chainguard took over maintenance of Kaniko after Google archived the project.

**Important Note:** This project and its maintainers are not affiliated with, endorsed by, or related to Chainguard in any way. This is an independent effort to provide a free alternative to commercial Kaniko images.


## Disclaimer

THIS SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

The authors and maintainers of this project assume no responsibility or liability for any damages, losses, or issues that may arise from the use of this software. Users are responsible for ensuring that their use of this software complies with all applicable laws and regulations.


## Bug Reports

Please report any bugs or issues via [GitHub Issues](https://github.com/infrabuilder/kaniko/issues).