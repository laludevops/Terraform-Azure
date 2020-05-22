# Azure Storage

Create storage account in Azure.

## Arguments

| Name | Type | Description |
| --- | --- | --- |
| `name` | `string` | The name of the storage account. |
| `resource_group_name` | `string` | The name of an existing resource group. |
| `sku` | `string` | The SKU of the storage account. Default: `Standard_RAGRS`. |
| `blobs` | `list` | List of blobs. |
| `containers` | `list` | List of containers. |
| `shares` | `list` | List of shares. |


The `containers` object must have the following keys:

| Name | Type | Description |
| --- | --- | --- |
| `name` | `string` | The name of the container. |
| `access_type` | `string` | Whether data in the container may be accessed publicly. The options are: `private`, `blob` and `container`. |
