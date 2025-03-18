# The Spark Devcontainer

This devcontainer is setup in such a way that we can push the prebuilt devcontainer (with its features and devcontainer settings) to our private Azure Container Registry. This achieves this goal:

- Engineers can spend less time waiting for the devcontainer to build as they can pull the prebuilt image.

## How to push changes to the prebuilt devcontainer

1. Make sure you have npm installed and devcontainers cli installed. If not install them
    - `npm install -g @devcontainers/cli`
1. Make your changes to the devcontainer folder.
1. Login to the [Azure Container Registry](https://ms.portal.azure.com/?feature.canmodifystamps=true&Microsoft_Azure_HybridData_Platform=dev#@microsoft.onmicrosoft.com/resource/subscriptions/a5082b19-8a6e-4bc5-8fdd-8ef39dfebc39/resourceGroups/alzahedi-spark/providers/Microsoft.ContainerRegistry/registries/sparkdevcontainer/overview). If not having access, ping alzahedi@microsoft.com
    - `az login --use-device-code`
    - `az acr login --name monitoringdev`
1. Run [build-img.sh](../scripts/build-img.sh) to build the image.
1. Run [push-img.sh](../scripts/push-img.sh) to push the image.

## How does the prebuilt devcontainer work?

1. First, we compute the file hash of all contents of the devcontainer folder. This is used as the tag for the prebuilt devcontainer image. `.devcontainer/devcontainer-hash.txt`
1. We then build the devcontainer image with the computed tag using the `devcontainer` cli tool.
    1. We instruct the `devcontainer` cli tool to use the `devcontainer.local.json` file instead of the default `devcontainer.json`.
    1. The `devcontainer.local.json` file uses the `Dockerfile.local` file to build it's image.
1. We then publish the image
    1. We publish the image to the [Azure Container Registry](https://ms.portal.azure.com/?feature.canmodifystamps=true&Microsoft_Azure_HybridData_Platform=dev#@microsoft.onmicrosoft.com/resource/subscriptions/a5082b19-8a6e-4bc5-8fdd-8ef39dfebc39/resourceGroups/alzahedi-spark/providers/Microsoft.ContainerRegistry/registries/sparkdevcontainer/overview).
    1. After this push happens, we automatically write the new image tag to the `devcontainer.json` file.
1. Finally, when any engineer opens the devcontainer, the `devcontainer.json` file is used to pull the prebuilt image from the [Azure Container Registry](https://ms.portal.azure.com/?feature.canmodifystamps=true&Microsoft_Azure_HybridData_Platform=dev#@microsoft.onmicrosoft.com/resource/subscriptions/a5082b19-8a6e-4bc5-8fdd-8ef39dfebc39/resourceGroups/alzahedi-spark/providers/Microsoft.ContainerRegistry/registries/sparkdevcontainer/overview).

## References

- [devcontainer Overview](https://code.visualstudio.com/docs/devcontainers/containers)
- [devcontainer CLI docs](https://containers.dev/implementors/reference/)
- [devcontainer image build example](https://github.com/devcontainers/cli/blob/main/example-usage/image-build/build-image.sh)
- [devcontainer metadata reference](https://containers.dev/implementors/json_reference/)
