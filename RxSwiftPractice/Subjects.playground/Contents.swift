import RxSwift

let disposeBag = DisposeBag()

print("-------publishSubject-------")
let publishSubject = PublishSubject<String>()

publishSubject.onNext("1. 여러분 안녕하세요?")

let 구독자1 = publishSubject
    .subscribe(onNext: {
        print("구독자1 : \($0)")
    })

publishSubject.onNext("2. 들리세요?")
publishSubject.onNext("3. 안들리시나요?")

구독자1.dispose()

let 구독자2 = publishSubject
    .subscribe(onNext: {
        print("구독자2 : \($0)")
    })

publishSubject.onNext("4. 여보세요.")
publishSubject.onCompleted()

publishSubject.onNext("5. 끝났나요")

구독자2.dispose()

publishSubject
    .subscribe {
        print("3 구독 : ", $0.element ?? $0)
    }
    .disposed(by: disposeBag)

publishSubject.onNext("5. 찍힐까요?")

print("-------behaviorSubject-------")
enum SubjectError: Error {
    case error1
}

let behaviorSubject = BehaviorSubject<String>(value: "0. 초기값")

behaviorSubject.onNext("1. 첫번째 값")

behaviorSubject
    .subscribe {
        print("첫번째 구독 : ", $0.element ?? $0)
    }
    .disposed(by: disposeBag)

//behaviorSubject.onError(SubjectError.error1)

behaviorSubject
    .subscribe {
        print("두번째 구독 : ", $0.element ?? $0)
    }
    .disposed(by: disposeBag)

let value = try? behaviorSubject.value()
print(value)

print("-------replaySubject-------")
let replaySubject = ReplaySubject<String>.create(bufferSize: 2)

replaySubject.onNext("1. 여러분")
replaySubject.onNext("2. 힘내세요")
replaySubject.onNext("3. 어렵지만")

replaySubject
    .subscribe {
        print("첫번째 구독 : ", $0.element ?? $0)
    }
    .disposed(by: disposeBag)

replaySubject
    .subscribe {
        print("두번째 구독 : ", $0.element ?? $0)
    }
    .disposed(by: disposeBag)

replaySubject.onNext("4. 할수있어요.")
replaySubject.onError(SubjectError.error1)

replaySubject.dispose()

replaySubject
    .subscribe {
        print("세번째 구독 : ", $0.element ?? $0)
    }.disposed(by: disposeBag)
