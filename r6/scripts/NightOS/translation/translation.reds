public class NOSTranslation {
    private func createArray(pointer: Int32) -> String {
        switch pointer {
            case 1: return "Forward";
            case 2: return "Backward";
            case 3: return "Left";
            case 4: return "Right";
            case 5: return "Stop";
            case 6: return "Explode";

            case 7: return "Turn Off";
            case 8: return "Turn On";
            case 9: return "Red";
            case 10: return "Green";
            case 11: return "Yellow";
            case 12: return "Glitching";

            case 13: return "Explode";
            case 14: return "Explode when NPC Near";

            case 15: return "Open";
            case 16: return "Close";
            case 17: return "Unlock";
            case 18: return "Lock";

            case 19: return "Open";

            case 20: return "Call";

            case 21: return "Control";
            case 22: return "Up";
            case 23: return "Down";

            case 24: return "Start/Stop";

            case 25: return "Distract";

            case 26: return "Next Channel";

            case 27: return "Dispense All";

            case 28: return "Steal Money";
        }
        return "";
    }
}