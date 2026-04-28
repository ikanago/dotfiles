import { McpServer } from "npm:@modelcontextprotocol/sdk/server/mcp.js";
import { StdioServerTransport } from "npm:@modelcontextprotocol/sdk/server/stdio.js";
import { z } from "npm:zod";

const server = new McpServer({
  name: "datadog_url_generator",
  version: "1.0.0",
});

server.tool(
  "generate_datadog_metric_url",
  "Generate a Datadog Metric Explorer URL with simple query parameters. Only supports a single metric per URL (no formulas). Call multiple times for multiple metrics.",
  {
    metric: z
      .string()
      .describe('Metric name (e.g. "system.cpu.user", "aws.elb.request_count")'),
    start: z
      .string()
      .describe(
        'Start time in unix seconds (numeric string only, e.g. "1700000000").'
      ),
    end: z
      .string()
      .describe(
        'End time in unix seconds (numeric string only, e.g. "1700003600").'
      ),
    aggregation: z
      .enum(["avg", "max", "min", "sum"])
      .default("avg")
      .describe("Aggregation function (default: avg)"),
    scope: z
      .array(z.string())
      .default([])
      .describe(
        'Filter scopes in key:value format (e.g. ["env:production", "service:web"])'
      ),
    group: z
      .array(z.string())
      .default([])
      .describe('Group by dimensions (e.g. ["host", "env"])'),
  },
  async (args) => {
    const { metric, start, end, aggregation, scope, group } = args;

    if (!/^\d+$/.test(start) || !/^\d+$/.test(end)) {
      return {
        content: [
          {
            type: "text" as const,
            text: `Error: start and end must be numeric unix seconds (integer). Got start="${start}", end="${end}".`,
          },
        ],
      };
    }

    const toMs = (sec: string): string => `${sec}000`;

    const params = new URLSearchParams();
    params.append("exp_metric", metric);
    params.append("exp_agg", aggregation);
    for (const s of scope) {
      params.append("exp_scope", s);
    }
    for (const g of group) {
      params.append("exp_group", g);
    }
    params.append("from_ts", toMs(start));
    params.append("to_ts", toMs(end));
    params.append("paused", "true");

    const url = `https://app.datadoghq.com/metric/explorer?${params.toString()}`;

    return {
      content: [
        {
          type: "text" as const,
          text: url,
        },
      ],
    };
  }
);

const transport = new StdioServerTransport();
await server.connect(transport);
