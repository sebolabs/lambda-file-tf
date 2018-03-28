resource "aws_lambda_function" "main" {
  function_name = "${format(
    "%s-%s-%s-%s",
    var.project,
    var.environment,
    var.component,
    var.name
  )}"

  description = "${upper(var.component)} ${upper(var.name)} lambda function (${upper(var.environment)} env)"

  filename         = "${var.filename}"
  source_code_hash = "${var.source_code_hash}"

  runtime     = "${var.runtime}"
  handler     = "${var.handler}"
  memory_size = "${var.memory_size}"
  timeout     = "${var.timeout}"
  publish     = "${var.publish}"

  role = "${aws_iam_role.main.arn}"

  environment {
    variables = "${var.env_variables}"
  }

  tags = "${merge(
    var.default_tags,
    local.tags,
    map(
      "Name", format(
        "%s-%s-%s-%s",
        var.project,
        var.environment,
        var.component,
        var.name
      )
    )
  )}"
}
