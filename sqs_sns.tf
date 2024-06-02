resource "aws_sqs_queue" "terraform_fifo_queue" {
  name                        = "terraform_fifo_queue.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
}