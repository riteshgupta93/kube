module "asg-master"{
    source = "./modules/asg"
    image_id = "ami-03d5c68bab01f3496"
    #user_data_base64 = base64encode(templatefile("${path.module}/template/node-user_data.sh", {}))
    user_data = templatefile("${path.module}/template/node-user_data.sh", {})
}
