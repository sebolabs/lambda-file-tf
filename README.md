# lambda-file-tf

**Info**
------
This Terraform module creates a Lambda function with a minimum set of resource required to cover default functionalities.

**_Note:_** This module expects 'filename' value to be provided in order to deploy code to the Lambda function.

**Usage**
------
```python
module "my-lambda" {
  source = "github.com/sebolabs/lambda-file-tf.git"

  project     = "lab"
  environment = "test"
  component   = "my-app"
  name        = "my-lambda"

  filename         = "${path.module}/archives/lambda.zip"
  source_code_hash = "${base64sha256(file("${path.module}/archives/lambda.zip"))}"

  runtime     = "nodejs6.10"
  handler     = "lambda.handler"
  memory_size = 128
  timeout     = 5

  env_variables = "${merge(
    var.env_vars,
    map(
      "MY_ENV", "TEST"
    )
  )}"

  cwlg_retention_in_days = 3
}
```

**Terraform compatibility**
------
TF versions tested: 0.11.2
