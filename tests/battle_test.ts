import {
  Clarinet,
  Tx,
  Chain,
  Account,
  types
} from 'https://deno.land/x/clarinet@v1.0.0/index.ts';
import { assertEquals } from 'https://deno.land/std@0.90.0/testing/asserts.ts';

Clarinet.test({
  name: "Ensure can battle monster",
  async fn(chain: Chain, accounts: Map<string, Account>) {
    let wallet_1 = accounts.get("wallet_1")!;
    
    let block = chain.mineBlock([
      Tx.contractCall(
        "character",
        "create-character", 
        ["Hero1"],
        wallet_1.address
      ),
      Tx.contractCall(
        "battle",
        "battle-monster",
        [types.uint(1)],
        wallet_1.address
      )
    ]);

    assertEquals(block.receipts.length, 2);
    assertEquals(block.receipts[1].result.expectOk(), true);
  },
});

Clarinet.test({
  name: "Ensure can get monster details",
  async fn(chain: Chain, accounts: Map<string, Account>) {
    let wallet_1 = accounts.get("wallet_1")!;
    
    let block = chain.mineBlock([
      Tx.contractCall(
        "battle",
        "get-monster",
        [types.uint(1)],
        wallet_1.address
      )
    ]);

    assertEquals(block.receipts.length, 1);
    assertEquals(block.receipts[0].result.expectOk(), true);
  },
});
