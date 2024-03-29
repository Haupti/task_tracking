import 'package:task/domain/cmd_parser.dart';
import 'package:test/test.dart';

void main() {
  test("parses list with shorthand", () {
    var (instr, err) = parseInstruction(["list", "-a"]);
    expect(err, null);
    expect(instr?.cmd, CommandArg.list);
    expect(instr?.opts, [OptionArg.all]);
    expect(instr?.args, []);
  });
  test("parses list with qualified", () {
    var (instr, err) = parseInstruction(["l", "--all"]);
    expect(err, null);
    expect(instr?.cmd, CommandArg.list);
    expect(instr?.opts, [OptionArg.all]);
    expect(instr?.args, []);
  });
}
