defmodule Vickrey.Mocks do

  def info_mock() do
    %{
      "bestblockhash" => "0000000000000000a3b1811037d95d13fbc3706f8f99f70c89202cfe9b2ed5ef",
      "blocks" => 51514,
      "chain" => "main",
      "chainwork" => "000000000000000000000000000000000000000000000ca4748221fd4ca775b4",
      "difficulty" => 933920891.2934244,
      "headers" => 51514,
      "mediantime" => 1611258463,
      "pruned" => false,
      "pruneheight" => nil,
      "softforks" => %{
        "hardening" => %{
          "bit" => 0,
          "startTime" => 1581638400,
          "statistics" => %{
            "count" => 0,
            "elapsed" => 1115,
            "period" => 2016,
            "possible" => false,
            "threshold" => 1916
          },
          "status" => "started",
          "timeout" => 1707868800
        },
        "testdummy" => %{
          "bit" => 28,
          "startTime" => 1199145601,
          "status" => "failed",
          "timeout" => 1230767999
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
       "highest" => 100000000,
       "hoursUntilClose" => 32,
       "name" => "blarg",
       "nameHash" => "2e1bac6540ab43cc4356f1f5b7f8ca26a6fd481cc46dac9aab2b7f82ca2133",
       "revealPeriodEnd" => 51706,
       "revealPeriodStart" => 50266,
       "state" => "REVEAL",
       "value" => 5000000
     }}

  end

end
