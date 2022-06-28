resource "null_resource" "tomer1" {
    count = 1
}

output "tf1_output" {
    value = var.tomer
}

output "tf1_output2" {
    value = 2
}

output "tf1_output3" {
    value = "some other value"
}
