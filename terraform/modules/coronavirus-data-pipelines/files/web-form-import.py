import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job

## @params: [JOB_NAME]
args = getResolvedOptions(sys.argv, ['JOB_NAME'])

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)
## @type: DataSource
## @args: [database = "${database}", table_name = "${table_name}", transformation_ctx = "datasource0"]
## @return: datasource0
## @inputs: []
datasource0 = glueContext.create_dynamic_frame.from_catalog(database = "${database}", table_name = "${table_name}", transformation_ctx = "datasource0")
## @type: ApplyMapping
## @args: [mapping = [("formresponse", "struct", "formresponse", "struct"), ("updated_at", "double", "updated_at", "double"), ("referenceid", "string", "referenceid", "string"), ("unixtimestamp", "double", "unixtimestamp", "double"), ("created_at", "double", "created_at", "double")], transformation_ctx = "applymapping1"]
## @return: applymapping1
## @inputs: [frame = datasource0]
applymapping1 = ApplyMapping.apply(frame = datasource0, mappings = [("formresponse", "struct", "formresponse", "struct"), ("updated_at", "double", "updated_at", "double"), ("referenceid", "string", "referenceid", "string"), ("unixtimestamp", "double", "unixtimestamp", "double"), ("created_at", "double", "created_at", "double")], transformation_ctx = "applymapping1")
## @type: DataSink
## @args: [connection_type = "s3", connection_options = {"path": "s3://${sink_bucket}/web-form-import"}, format = "json", transformation_ctx = "datasink2"]
## @return: datasink2
## @inputs: [frame = applymapping1]
datasink2 = glueContext.write_dynamic_frame.from_options(frame = applymapping1, connection_type = "s3", connection_options = {"path": "s3://${sink_bucket}/sink"}, format = "json", transformation_ctx = "datasink2")
job.commit()
