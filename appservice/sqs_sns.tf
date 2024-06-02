resource "aws_sqs_queue" "terraform_fifo_queue" {
  name                        = "terraform_fifo_queue.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
}

resource "aws_sns_topic" "terraform_fifo_topic" {
  name                        = "terraform_fifo_topic.fifo"
  fifo_topic                  = true
  content_based_deduplication = true
}