# Quick reference

- **GitHub Link:** https://www.github.com/sehwol/docker-docfx
- **DockerHub Link:** https://hub.docker.com/r/daemoncore/docfx


# Supported tags and respective Dockerfile links

- `2.43.5-slim-buster`, `latest`


# What is DocFX?

DocFX is a static documentation generator.
<br/>
- https://github.com/dotnet/docfx
- https://dotnet.github.io/docfx/tutorial/docfx_getting_started.html


# How to use this image

This image is mainly for GitLab .NET continuous integration pipelines. For
example, once the GitLab runner reached the `pages` job, it can use this
image to create HTML documentation pages that is available on *gitlab.io*.

Below is a sample *.gitlab-ci.yml* for this.


## Create a *.gitlab-ci.yml* file in your root folder

```
image: mcr.microsoft.com/dotnet/core/sdk:3.1

variables:
    GIT_DEPTH: 1
    NUGET_PACKAGES_DIRECTORY: .nuget

stages:
    - build
    - test
    - deploy

cache:
    key: ${CI_COMMIT_REF_SLUG}
    paths:
        - ${NUGET_PACKAGES_DIRECTORY}

before_script:
    - dotnet restore --packages ${NUGET_PACKAGES_DIRECTORY}

build:
    stage: build
    script: dotnet build --no-restore

test:
    stage: test
    script: dotnet test --no-restore

pages:
    image: daemoncore/docfx:
    stage: deploy
    before_script:
        - ''
    rules: 
        - if: '$CI_COMMIT_REF_NAME == "master"'
          when: always
    script: 
        - docfx metadata docs/docfx.json
        - docfx docs/docfx.json -o temp
        - mv temp/_site public
    artifacts:
        paths:
            - public

```
