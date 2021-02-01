defmodule Vickrey.Mocks do
  def info_mock() do
    %{
      "bestblockhash" => "0000000000000000a3b1811037d95d13fbc3706f8f99f70c89202cfe9b2ed5ef",
      "blocks" => 51514,
      "chain" => "main",
      "chainwork" => "000000000000000000000000000000000000000000000ca4748221fd4ca775b4",
      "difficulty" => 933_920_891.2934244,
      "headers" => 51514,
      "mediantime" => 1_611_258_463,
      "pruned" => false,
      "pruneheight" => nil,
      "softforks" => %{
        "hardening" => %{
          "bit" => 0,
          "startTime" => 1_581_638_400,
          "statistics" => %{
            "count" => 0,
            "elapsed" => 1115,
            "period" => 2016,
            "possible" => false,
            "threshold" => 1916
          },
          "status" => "started",
          "timeout" => 1_707_868_800
        },
        "testdummy" => %{
          "bit" => 28,
          "startTime" => 1_199_145_601,
          "status" => "failed",
          "timeout" => 1_230_767_999
        }
      },
      "treeroot" => "35d7ba4d13aecd128e94e43fddb95da5d739d1fec5fed2c98b4413891dad86d4",
      "verificationprogress" => 1
    }
  end

  def search_mock() do
    {:ok,
     %{
       "blocksUntilClose" => 192,
       "claimed" => 0,
       "height" => 51509,
       "highest" => 100_000_000,
       "hoursUntilClose" => 32,
       "name" => "blarg",
       "nameHash" => "2e1bac6540ab43cc4356f1f5b7f8ca26a6fd481cc46dac9aab2b7f82ca2133",
       "revealPeriodEnd" => 51706,
       "revealPeriodStart" => 50266,
       "state" => "REVEAL",
       "value" => 5_000_000
     }}
  end

  def last_block_parsed() do
    {[
       %{action: "BID", name: ["4gab"], value: 6.5},
       %{action: "BID", name: ["pismo"], value: 7.2},
       %{action: "BID", name: ["som1"], value: 5.4}
     ],
     [
       %{action: "OPEN", name: ["4gab"], value: 6.5},
       %{action: "OPEN", name: ["pismo"], value: 7.2},
       %{action: "OPEN", name: ["sm1"], value: 5.4},
       %{action: "OPEN", name: ["4ab"], value: 6.5},
       %{action: "OPEN", name: ["ismo"], value: 7.2},
       %{action: "OPEN", name: ["om1"], value: 5.4},
       %{action: "OPEN", name: ["gab"], value: 6.5},
       %{action: "OPEN", name: ["smo"], value: 7.2},
       %{action: "OPEN", name: ["m1"], value: 5.4},
       %{action: "OPEN", name: ["4gab"], value: 6.5},
       %{action: "OPEN", name: ["pismo"], value: 7.2},
       %{action: "OPEN", name: ["sm1"], value: 5.4},
       %{action: "OPEN", name: ["4ab"], value: 6.5},
       %{action: "OPEN", name: ["ismo"], value: 7.2},
       %{action: "OPEN", name: ["om1"], value: 5.4},
       %{action: "OPEN", name: ["gab"], value: 6.5},
       %{action: "OPEN", name: ["smo"], value: 7.2},
       %{action: "OPEN", name: ["m1"], value: 5.4}
     ]}
  end
end
