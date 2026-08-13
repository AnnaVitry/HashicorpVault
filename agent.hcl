
vault {
  address = "http://127.0.0.1:8200"
}

auto_auth {
  method "approle" {
    config = {
      role_id_file_path = "role_id.txt"
      secret_id_file_path = "secret_id.txt"
      remove_secret_id_file_after_reading = false
    }
  }
}

template {
  source      = "app_config.tpl"
  destination = "config_generee.txt"
}
