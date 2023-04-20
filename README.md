<h1> Hoppscotch Helm Charts [WIP] </h1>

<!-- Keep full URL links to repo files because this README syncs from main to gh-pages.  -->

![Chart Version](https://img.shields.io/github/v/release/wdaan/hoppscotch-helm?label=chart%20version)
![hoppscotch Version](https://img.shields.io/github/v/release/hoppscotch/hoppscotch?color=green&label=hoppscotch%20version)

# Disclaimer
These charts are still a work in progress. They provide a base that deploys the 3 components [backend, web, admin] as seperate deployments. However I think that currently the frontend/admin don't allow envs dynamic envs. As long as this is not implemented I fear this way of deploying will not work.

Also I am not a maintainer or in any way related to the hoppscotch project, I made this as a starter template and hope that the hoppscotch team will transfer this repo over to their org.

Please [create an issue](https://github.com/hoppscotch-io/helm-charts/issues/new) or submit a pull request for any issues or missing features.

<h2> Contents </h2>

- [Disclaimer](#disclaimer)
- [Usage](#usage)
- [Installing](#installing)
- [Upgrading](#upgrading)
- [Configuration](#configuration)
  - [YAML](#yaml)
- [Contributing](#contributing)
- [License](#license)

# Usage

[Helm](https://helm.sh) must be installed to use the charts.
Please refer to Helm's [documentation](https://helm.sh/docs/) to get started.

Once Helm is set up properly, add the repo as follows:

```console
helm repo add hoppscotch https://wdaan.github.io/hoppscotch-helm/
```

You can then run `helm search repo hoppscotch` to see the charts.

# Installing

```console
helm install hoppscotch hoppscotch/hoppscotch
```

# Upgrading

```console
helm upgrade hoppscotch hoppscotch/hoppscotch
```

# Configuration

You can configure this chart by updating create a custom values file.

See the [hoppscotch documentation](https://docs.hoppscotch.io/documentation/self-host/getting-started) for more information.

## YAML

You can also configure this chart using YAML. See the [values.yaml](charts/hoppscotch/values.yaml#L34) file for the default values under `global.env`.

# Contributing

Feel free to open up a PR.

# License

[MIT License](https://github.com/hoppscotch-io/helm-charts/blob/main/LICENSE).
