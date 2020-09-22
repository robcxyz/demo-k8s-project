
data "template_file" "nginx_ingress" {
  template = yamlencode(yamldecode(file("${path.module}/nginx_ingress.yaml")))
}


resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress"
  chart      = "stable/nginx-ingress"
  repository = data.helm_repository.stable.metadata[0].name
  namespace  = "kube-system"

  values = [data.template_file.nginx_ingress.rendered]
}