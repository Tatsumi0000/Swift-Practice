import Foundation
import Combine

/// サンプルのモデル
public struct SampleModel: Decodable {
    /// 適当なID
    public let id: Int
    /// こっちのplanはあくまでJsonからの文字列を受け取るだけにするのでprivateにする
    private let plan: String

    public enum Plan: String {
        case free = "free"
        case premium = "premium"
        case notFound = "notFound"
    }

    /// ここで想定外のプラン（文字列）が返ってきたときに一括でnotFoundを返す
    public var contractPlan: Plan {
        return Plan(rawValue: plan) ?? .notFound
    }

}

/// 普通に使うパターン
public func convertModelStringToEnumSample1() {
    var cancellable: AnyCancellable?
    
    cancellable = """
    {
        "id": 1,
        "plan": "free"
    }
    """
        .data(using: .utf8)
        .publisher
        .decode(type: SampleModel.self, decoder: JSONDecoder())
        .print()
        .sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                print("convertModelStringToEnumSample1 finished! \n")
            case .failure(let error):
                print(error)
            }
        }, receiveValue: { decodedValue in
            print(decodedValue.contractPlan)
        })

}

/// planにtestという想定外のパラメータが送られたという体でいい感じにするパターン
public func convertModelStringToEnumSample2() {
    var cancellable: AnyCancellable?
    
    cancellable = """
    {
        "id": 2,
        "plan": "test"
    }
    """
        .data(using: .utf8)
        .publisher
        .decode(type: SampleModel.self, decoder: JSONDecoder())
        .print()
        .sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                print("convertModelStringToEnumSample2 finished! \n")
            case .failure(let error):
                print(error)
            }
        }, receiveValue: { decodedValue in
            // 未定義の「test」がplanに入っているのでnotFoundを返してくれる
            print(decodedValue.contractPlan)
        })

}

/// planをenumに変換するからfilter()とかがいい感じに使えるよということを示すパターン
public func convertModelStringToEnumSample3() {
    var cancellable: AnyCancellable?
    
    cancellable = """
    {
        "id": 2,
        "plan": "test"
    }
    """
        .data(using: .utf8)
        .publisher
        .decode(type: SampleModel.self, decoder: JSONDecoder())
        .print()
        // いい感じにenumを使ったフィルターが出来る
        // enumにするので、補完でプラン名が出る
        // そのため直接planのStringで比較するよりタイプミスなどが減る（はず）
        .filter({ $0.contractPlan == .free })
        .sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                print("convertModelStringToEnumSample3 finished! \n")
            case .failure(let error):
                print(error)
            }
        }, receiveValue: { decodedValue in
            print(decodedValue.contractPlan)
        })

}
