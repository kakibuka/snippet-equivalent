func foo() {}

func bar() async {
    try? await Task.sleep(for: .seconds(1))
}

let clock = ContinuousClock();
let elapsedTime = clock.measure {
    foo()
}
let elapsedTime2 = await clock.measure {
    await bar()
}
    
print(elapsedTime)
print(elapsedTime2)