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
## @args: [mapping = [("customer_callling_number", "string", "customer_callling_number", "string"), ("nhs_number", "string", "nhs_number", "string"), ("current_item_id", "string", "current_item_id", "string"), ("transfer", "string", "transfer", "string"), ("fallback_time", "string", "fallback_time", "string"), ("nhs_known", "string", "nhs_known", "string"), ("contact_id", "string", "contact_id", "string"), ("call_timestamp", "timestamp", "call_timestamp", "timestamp"), ("nhs_number_2", "string", "nhs_number_2", "string"), ("dob", "string", "dob", "string"), ("dob_2", "string", "dob_2", "string"), ("postal_code", "string", "postal_code", "string"), ("preferred_phone_number", "string", "preferred_phone_number", "string"), ("phone_number_calls", "string", "phone_number_calls", "string"), ("postal_code_verified", "string", "postal_code_verified", "string"), ("delivery_supplies", "string", "delivery_supplies", "string"), ("carry_supplies", "string", "carry_supplies", "string"), ("have_help", "string", "have_help", "string"), ("umet_needs", "string", "umet_needs", "string")], transformation_ctx = "applymapping1"]
## @return: applymapping1
## @inputs: [frame = datasource0]
applymapping1 = ApplyMapping.apply(frame = datasource0, mappings = [("customer_callling_number", "string", "customer_callling_number", "string"), ("nhs_number", "string", "nhs_number", "string"), ("current_item_id", "string", "current_item_id", "string"), ("transfer", "string", "transfer", "string"), ("fallback_time", "string", "fallback_time", "string"), ("nhs_known", "string", "nhs_known", "string"), ("contact_id", "string", "contact_id", "string"), ("call_timestamp", "timestamp", "call_timestamp", "timestamp"), ("nhs_number_2", "string", "nhs_number_2", "string"), ("dob", "string", "dob", "string"), ("dob_2", "string", "dob_2", "string"), ("postal_code", "string", "postal_code", "string"), ("preferred_phone_number", "string", "preferred_phone_number", "string"), ("phone_number_calls", "string", "phone_number_calls", "string"), ("postal_code_verified", "string", "postal_code_verified", "string"), ("delivery_supplies", "string", "delivery_supplies", "string"), ("carry_supplies", "string", "carry_supplies", "string"), ("have_help", "string", "have_help", "string"), ("umet_needs", "string", "umet_needs", "string")], transformation_ctx = "applymapping1")
## @type: DataSink
## @args: [connection_type = "s3", connection_options = {"path": "s3://${sink_bucket}/sink"}, format = "json", transformation_ctx = "datasink2"]
## @return: datasink2
## @inputs: [frame = applymapping1]
datasink2 = glueContext.write_dynamic_frame.from_options(frame = applymapping1, connection_type = "s3", connection_options = {"path": "s3://${sink_bucket}/sink"}, format = "json", transformation_ctx = "datasink2")
job.commit()
