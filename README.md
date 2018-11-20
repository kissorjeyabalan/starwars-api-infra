# 
## Deployment
1. Fork sw-api-infra and sw-api.
2. In sw-api-infra, edit the credentials_example.yml file with your information. Leave `graphite_carbon_X` empty.
3. Rename the file to credentials.yml.
4. In sw-api-infra, edit the `terraform/variables.tf` file with desired application name and pipeline name. `Do not` append or prefix -ci, -staging or -production to the application name.
5. While in the sw-api-infra, run the following command:

`fly -t <TARGET> -p swapi_pipeline -c concourse/pipeline.yaml -l credentials.yml`

After unpausing the pipeline, both the infrastructure and application jobs should start automatically.

Once infra job is finished:
1. Log into heroku
2. Open the created pipeline
3. Open the ci application
4. Open the hostedgraphite addon
5. Find the carbon url (graphite host) and copy it
6. Paste it into `graphite_carbon_ci` in `credentials.yml`.
7. Repeat steps 1 to 6 for `staging` and `production` app.
8. Run the `update-metric-keys` job in concourse.

By the time you're done with adding the metric keys, the deployment of application should have succeeded.

## Tasks done
- Docker
    - Pipeline builds and deploys to Heroku with docker image
- Overvåkning, varsling og Metrics
    - StatusCake to monitor endpoints
    - HostedGraphite for metrics. 
    - Meter, counter and timer implemented in application.
- Applikasjonslogger
    - 
## Known issues
- Due to using docker image and a hobby plan, the instance provided by heroku does not have enough memory to start the application within 60s on the first try. Therefore, swagger which is implemented, is disabled (as the application would never start in time). Even with swagger disabled, it might take a few tries before it succeeds. You can force a application restart by running the `update-metric-keys` job, if Heroku doesn't want to automatically retry.
- Free tier of hosted graphite does not have enough metrics to show all metrics added to application

## Improvements
Additional improvements made:
- Cache maven repositories
- Infrastructure job will never fail when ran several times