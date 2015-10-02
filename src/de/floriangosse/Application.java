package de.floriangosse;

public class Application {
    public static void main (String args[]) {
        for (int i = 0; i < args.length; i++) {
            System.out.println("Argument " + i + ": " + args[i]);
        }
    }
}
