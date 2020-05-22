output "terraform_storage_account_info" {
    value = {
        name = lookup(module.storage_account_terraform_state.sst_output, "name", "")
        id = lookup(module.storage_account_terraform_state.sst_output, "id", "")
    }
}

output "terraform_level_1_container_info" {
    value = {
        name = lookup(lookup(module.storage_account_terraform_state.cnt_output, "0001", {}), "name", "")
        id = lookup(lookup(module.storage_account_terraform_state.cnt_output, "0001", {}), "id", "")
    }
}

output "terraform_level_2_container_info" {
    value = {
        name = lookup(lookup(module.storage_account_terraform_state.cnt_output, "0002", {}), "name", "")
        id   = lookup(lookup(module.storage_account_terraform_state.cnt_output, "0002", {}), "id", "")
    }
}