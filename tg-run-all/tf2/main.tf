resource "null_resource" "tomer3" {
    count = 2
}

output "tf2_output" {
  value = var.tomer
}

 output "tf2_output2" {
     value = 34243
 }

 output "tf2_output3" {
     value = "some tf2  other value"
 }
