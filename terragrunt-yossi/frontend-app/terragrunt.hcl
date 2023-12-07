dependency "backend_app" {
    config_path = "../backend-app"
    skip_outputs = true
}

inputs = {
    backend_output = dependency.backend_app.outputs.backend_output
}
