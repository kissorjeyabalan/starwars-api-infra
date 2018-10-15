#### CI
resource "heroku_app" "ci" {
  name = "${var.app_prefix}-ci"
  region = "eu"
}

resource "heroku_addon" "db_ci" {
  app = "${heroku_app.ci.name}"
  plan = "heroku-postgresql:hobby-dev"
}

#### Staging
resource "heroku_app" "staging" {
  name = "${var.app_prefix}-staging"
  region = "eu"
}

resource "heroku_addon" "db_staging" {
  app = "${heroku_app.staging.name}"
  plan = "heroku-postgresql:hobby-dev"
}

#### Production
resource "heroku_app" "production" {
  name = "${var.app_prefix}-prod"
  region = "eu"
}

resource "heroku_addon" "db_prod" {
  app = "${heroku_app.production.name}"
  plan = "heroku-postgresql:hobby-dev"
}

### Add stages to pipeline
resource "heroku_pipeline" "swapi" {
  name = "${var.pipeline_name}"
}

resource "heroku_pipeline_coupling" "ci" {
  app = "${heroku_app.ci.name}"
  pipeline = "${heroku_pipeline.swapi.id}"
  stage = "development"
}

resource "heroku_pipeline_coupling" "staging" {
  app = "${heroku_app.staging.name}"
  pipeline = "${heroku_pipeline.swapi.id}"
  stage = "staging"
}

resource "heroku_pipeline_coupling" "production" {
  app = "${heroku_app.production.name}"
  pipeline = "${heroku_pipeline.swapi.id}"
  stage = "production"
}
