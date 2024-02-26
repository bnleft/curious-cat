struct Cat {
    func meow() -> String {
        let catSayings = [
            "I liek! I chase da red dot!",
            "Purrs for days...",
            "I want to see crab again",
            "GIB ME LASAGNA!!!",
            "Mewwwwoooo",
            "what happen to the model ;-;",
            ">.< pwease worrrrk"
        ]
        
        return catSayings.randomElement()!
    }
}
