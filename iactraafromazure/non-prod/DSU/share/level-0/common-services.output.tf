output "terraform_storage_account_info" {
    value = {
        name = lookup(module.storage_account_terraform_state.sst_output, "name", "")
        id = lookup(module.storage_account_terraform_state.sst_output, "id", "")
    }
}

output "dsu_terraform_level_1_container_info" {
    value = {
        name = lookup(lookup(module.storage_account_terraform_state.cnt_output, "dsu-0001", {}), "name", "")
        id = lookup(lookup(module.storage_account_terraform_state.cnt_output, "dsu-0001", {}), "id", "")
    }
}

output "dsu_terraform_level_2_container_info" {
    value = {
        name = lookup(lookup(module.storage_account_terraform_state.cnt_output, "dsu-0002", {}), "name", "")
        id   = lookup(lookup(module.storage_account_terraform_state.cnt_output, "dsu-0002", {}), "id", "")
    }
}


output "dev_terraform_level_1_container_info" {
    value = {
        name = lookup(lookup(module.storage_account_terraform_state.cnt_output, "dev-0001", {}), "name", "")
        id = lookup(lookup(module.storage_account_terraform_state.cnt_output, "dev-0001", {}), "id", "")
    }
}

output "dev_terraform_level_2_container_info" {
    value = {
        name = lookup(lookup(module.storage_account_terraform_state.cnt_output, "dev-0002", {}), "name", "")
        id = lookup(lookup(module.storage_account_terraform_state.cnt_output, "dev-0002", {}), "id", "")
    }
}


output "sit_terraform_level_1_container_info" {
    value = {
        name = lookup(lookup(module.storage_account_terraform_state.cnt_output, "sit-0001", {}), "name", "")
        id = lookup(lookup(module.storage_account_terraform_state.cnt_output, "sit-0001", {}), "id", "")
    }
}

output "sit_terraform_level_2_container_info" {
    value = {
        name = lookup(lookup(module.storage_account_terraform_state.cnt_output, "sit-0002", {}), "name", "")
        id = lookup(lookup(module.storage_account_terraform_state.cnt_output, "sit-0002", {}), "id", "")
    }
}


output "uat_terraform_level_1_container_info" {
    value = {
        name = lookup(lookup(module.storage_account_terraform_state.cnt_output, "uat-0001", {}), "name", "")
        id = lookup(lookup(module.storage_account_terraform_state.cnt_output, "uat-0001", {}), "id", "")
    }
}

output "uat_terraform_level_2_container_info" {
    value = {
        name = lookup(lookup(module.storage_account_terraform_state.cnt_output, "uat-0002", {}), "name", "")
        id = lookup(lookup(module.storage_account_terraform_state.cnt_output, "uat-0002", {}), "id", "")
    }
}