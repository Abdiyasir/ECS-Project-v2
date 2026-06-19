resource "aws_wafv2_web_acl" "WafWebAcl" {
  name  = "alb-waf"
  scope = "REGIONAL"

  default_action {
    allow {}
  }

visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "WAF_Total_Metrics"
    sampled_requests_enabled   = true
  }

rule {
    name     = "known_bad_inputs"
    priority = 0
    override_action {
      none {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesKnownBadInputsRuleSet"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "bad_inputs_metrics"
      sampled_requests_enabled   = true
    }
  }

rule {
    name     = "ip_reputation_list"
    priority = 10
    override_action {
      none {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesAmazonIpReputationList"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "ip_reputation_metrics"
      sampled_requests_enabled   = true
    }
  }

rule {
    name     = "common_rules"
    priority = 20
    override_action {
      none {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"

        rule_action_override {
          action_to_use {
            allow {}
          }
          name = "SizeRestrictions_BODY"
        }

        rule_action_override {
          action_to_use {
            allow {}
          }
          name = "NoUserAgent_HEADER"
        }
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "common_rules_metrics"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "sql_injection_rules"
    priority = 30

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesSQLiRuleSet"
        vendor_name = "AWS"
    
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "sql_injection_metrics" 
      sampled_requests_enabled   = true
    }
  }
}

resource "aws_wafv2_web_acl_logging_configuration" "waf_logging_config" {
  log_destination_configs = [var.waf_log_group_arn]
  resource_arn = aws_wafv2_web_acl.WafWebAcl.arn

  redacted_fields {
    uri_path {}
  }
}

resource "aws_wafv2_web_acl_association" "alb_association" {
  resource_arn = var.alb_arn
  web_acl_arn  = aws_wafv2_web_acl.WafWebAcl.arn
}
