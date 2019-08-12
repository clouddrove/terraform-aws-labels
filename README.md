## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| attributes | Additional attributes, e.g. `1` | list | `<list>` | no |
| delimiter | Delimiter to be used between `organization`, `name`, `environment` and `attributes` | string | `-` | no |
| enabled | Set to false to prevent the module from creating any resources | string | `true` | no |
| name | Solution name, e.g. `app` | string | - | yes |
| organization | organization, which could be your organization name, e.g. `cp` or `anmolnagpal` | string | - | yes |
| environment | environment, e.g. `prod`, `staging`, `dev`, or `test` | string | - | yes |
| tags | Additional tags (e.g. `map(`BusinessUnit`,`XYZ`) | map | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| attributes | Normalized attributes |
| id | Disambiguated ID |
| name | Normalized name |
| organization | Normalized organization |
| environment | Normalized environment |
| tags | Normalized Tag map |

## 👬 Contribution
- Open pull request with improvements
- Discuss ideas in issues

- Reach out with any feedback [![Twitter URL](https://img.shields.io/twitter/url/https/twitter.com/anmol_nagpal.svg?style=social&label=Follow%20%40anmol_nagpal)](https://twitter.com/anmol_nagpal)
