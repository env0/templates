# tf file with error
resource "helm_release" "heml" {
 name = "my-helm-release"
 values = [
 <<EOF
 image
 repository: nginx
 tag: 1.16.0
 pullPolicy: IfNotPresent
 EOF
 ]
 chart = "./myetc.tar.gz"
}
