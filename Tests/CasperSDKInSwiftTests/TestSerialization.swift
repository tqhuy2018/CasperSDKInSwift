import XCTest
@testable import CasperSDKInSwift
final class TestSerialization: XCTestCase {
    func testAll() throws {
        do {
            //Serialization test
            
            //test for bool
            var bool_true:String = CLTypeSerializeHelper.BoolSerialize(input: true)
            var bool_false:String = CLTypeSerializeHelper.BoolSerialize(input: false)
            XCTAssert(bool_true == "01")
            XCTAssert(bool_false == "00")
            
            //test for u8
            var u8_1:String = CLTypeSerializeHelper.UInt8Serialize(input: 197)
            var u8_2:String = CLTypeSerializeHelper.UInt8Serialize(input: 7)
            var u8_3:String = CLTypeSerializeHelper.UInt8Serialize(input: 0)
            XCTAssert(u8_1 == "c5")
            XCTAssert(u8_2 == "07")
            XCTAssert(u8_3 == "00")
            
            //test for i32
            let i32_1:String = CLTypeSerializeHelper.Int32Serialize(input: -1024)
            let i32_2:String = CLTypeSerializeHelper.Int32Serialize(input: 1000)
            let i32_3:String = CLTypeSerializeHelper.Int32Serialize(input: 0)
            XCTAssert(i32_1=="00fcffff")
            XCTAssert(i32_2=="e8030000")
            XCTAssert(i32_3=="00000000")

            //test for i64
            let i64_1:String = CLTypeSerializeHelper.Int64Serialize(input: -1024)
            let i64_2:String = CLTypeSerializeHelper.Int64Serialize(input: 1000)
            let i64_3:String = CLTypeSerializeHelper.Int64Serialize(input: 0)
            XCTAssert(i64_1=="00fcffffffffffff")
            XCTAssert(i64_2=="e803000000000000")
            XCTAssert(i64_3=="0000000000000000")
            
            //test for u32
            let u32_1:String = CLTypeSerializeHelper.UInt32Serialize(input: 1024)
            let u32_2:String = CLTypeSerializeHelper.UInt32Serialize(input: 5531024)
            let u32_3:String = CLTypeSerializeHelper.UInt32Serialize(input: 0)
            XCTAssert(u32_1 == "00040000")
            XCTAssert(u32_2 == "90655400")
            XCTAssert(u32_3 == "00000000")
            
            //test for u64
            let u64_1:String = CLTypeSerializeHelper.UInt64Serialize(input: 1024)
            let u64_2:String = CLTypeSerializeHelper.UInt64Serialize(input: 33009900995531024)
            let u64_3:String = CLTypeSerializeHelper.UInt64Serialize(input: 0)
            XCTAssert(u64_1 == "0004000000000000")
            XCTAssert(u64_2 == "10d1e87e54467500")
            XCTAssert(u64_3 == "0000000000000000")
            
            //test for u128
            let u128_1 =  try CLTypeSerializeHelper.U128Serialize(input:"123456789101112131415")
            let u128_2 =  try CLTypeSerializeHelper.U128Serialize(input:"1024")
            let u128_3 =  try CLTypeSerializeHelper.U128Serialize(input:"0")
            XCTAssert(u128_1 == "0957ff1ada959f4eb106")
            XCTAssert(u128_2 == "020004")
            XCTAssert(u128_3 == "0100")
            
            //test for u256
            let u256_1 =  try CLTypeSerializeHelper.U256Serialize(input:"999988887777666655556666777888999")
            let u256_2 =  try CLTypeSerializeHelper.U256Serialize(input:"2048")
            let u256_3 =  try CLTypeSerializeHelper.U256Serialize(input:"0")
            XCTAssert(u256_1 == "0ee76837d2ca215879f7bc5ca24d31")
            XCTAssert(u256_2 == "020008")
            XCTAssert(u256_3 == "0100")
            
            //test for u512
            let u512_1 =  try CLTypeSerializeHelper.U512Serialize(input:"999888666555444999887988887777666655556666777888999666999")
            let u512_2 =  try CLTypeSerializeHelper.U512Serialize(input:"4096")
            let u512_3 =  try CLTypeSerializeHelper.U512Serialize(input:"0")
            let u512_4 =  try CLTypeSerializeHelper.U512Serialize(input: "100000000")
            XCTAssert(u512_1 == "1837f578fca55492f299ea354eaca52b6e9de47d592453c728")
            XCTAssert(u512_2 == "020010")
            XCTAssert(u512_3 == "0100")
            XCTAssert(u512_4 == "0400e1f505")
            
            //test for string
            let str:String = "Hello, World!"
            let strSerialize = CLTypeSerializeHelper.StringSerialize(input: "Hello, World!")
            XCTAssert(strSerialize == "0d00000048656c6c6f2c20576f726c6421")
            let str2:String = "lWJWKdZUEudSakJzw1tn"
            let strSerialize2 = CLTypeSerializeHelper.StringSerialize(input: str2)
            XCTAssert(strSerialize2 == "140000006c574a574b645a5545756453616b4a7a7731746e")
            let str3:String = "S1cXRT3E1jyFlWBAIVQ8"
            let str3Serialize = CLTypeSerializeHelper.StringSerialize(input: str3)
            XCTAssert(str3Serialize == "140000005331635852543345316a79466c57424149565138")
            let str4:String = "123456789123456789123456789123456789123456789123456789"
            let str4Serialize = CLTypeSerializeHelper.StringSerialize(input: str4)
            XCTAssert(str4Serialize=="36000000313233343536373839313233343536373839313233343536373839313233343536373839313233343536373839313233343536373839")
            //test for Unit
            let unit : CLValueWrapper = .Unit("")
            do {
                let unitSerialize = try CLTypeSerializeHelper.CLValueSerialize(input: unit)
                XCTAssert(unitSerialize=="")
            } catch {
                throw CasperError.invalidNumber
            }
            //test for Key
            //1. Account Hash
            let key1 : CLValueWrapper = .Key("account-hash-d0bc9cA1353597c4004B8F881b397a89c1779004F5E547e04b57c2e7967c6269")
            do {
                let keySerialize = try CLTypeSerializeHelper.CLValueSerialize(input: key1)
                XCTAssert(keySerialize == "00d0bc9cA1353597c4004B8F881b397a89c1779004F5E547e04b57c2e7967c6269")
            } catch {
                throw CasperError.invalidNumber
            }
            //test for URef
            //test for PublicKey
            //test for Option
            
            //test for List
            //List of 3 U32 numbers
            let item1:CLValueWrapper = .U32(1)
            let item2:CLValueWrapper = .U32(2)
            let item3:CLValueWrapper = .U32(3)
            let clValue:CLValueWrapper = .ListWrapper([item1,item2,item3])
            do {
                let clValueSerialization = try CLTypeSerializeHelper.CLValueSerialize(input: clValue)
                XCTAssert(clValueSerialization=="03000000010000000200000003000000")
            } catch {
                
            }
            
            //List of 3 String
            let listStr1:CLValueWrapper = .String("Hello, World!")
            let listStr2:CLValueWrapper = .String("Bonjour le monde")
            let listStr3:CLValueWrapper = .String("Hola Mundo")
            let clValueStringList:CLValueWrapper = .ListWrapper([listStr1,listStr2,listStr3])
            do {
                let clStringListSerialization = try CLTypeSerializeHelper.CLValueSerialize(input: clValueStringList)
                XCTAssert(clStringListSerialization=="030000000d00000048656c6c6f2c20576f726c642110000000426f6e6a6f7572206c65206d6f6e64650a000000486f6c61204d756e646f")
            } catch {
                
            }
            //test for ByteArray
            let ba:CLValueWrapper = .BytesArray("006d0be2fb64bcc8d170443fbadc885378fdd1c71975e2ddd349281dd9cc59cc")
            do {
                let baSerialization = try CLTypeSerializeHelper.CLValueSerialize(input: ba, withPrefix0x: false)
                XCTAssert(baSerialization == "006d0be2fb64bcc8d170443fbadc885378fdd1c71975e2ddd349281dd9cc59cc")
            } catch {
                throw CasperError.invalidNumber
            }
            //test for Result
            //Result ok
            let resultCLValue : CLValueWrapper = .ResultWrapper("Ok", .U64(314))
            do {
                let resultCLValueSerialization = try CLTypeSerializeHelper.CLValueSerialize(input: resultCLValue)
                XCTAssert(resultCLValueSerialization=="013a01000000000000")
            } catch {
                
            }
            //Result err
            let resultErrCLValue : CLValueWrapper = .ResultWrapper("Err", .String("Uh oh"))
            do {
                let resultCLValueErrSerialization = try CLTypeSerializeHelper.CLValueSerialize(input: resultErrCLValue)
                XCTAssert(resultCLValueErrSerialization=="00050000005568206f68")
            } catch {
                
            }
            //test for Tuple1
            let tuple1CLValue : CLValueWrapper = .Tuple1Wrapper(.String("Hello, World!"))
            let tuple2CLValue : CLValueWrapper = .Tuple1Wrapper(.U32(1))
            let tuple3CLValue : CLValueWrapper = .Tuple1Wrapper(.Bool(true))
            do {
                let tuple1Serialization = try CLTypeSerializeHelper.CLValueSerialize(input: tuple1CLValue)
                XCTAssert(tuple1Serialization == "0d00000048656c6c6f2c20576f726c6421")
                let tuple2Serialization = try CLTypeSerializeHelper.CLValueSerialize(input: tuple2CLValue)
                XCTAssert(tuple2Serialization == "01000000")
                let tuple3Serialization = try CLTypeSerializeHelper.CLValueSerialize(input: tuple3CLValue)
                XCTAssert(tuple3Serialization == "01")
            } catch {
                
            }
            //test for Tuple2
            do {
                let tupleType2 : CLValueWrapper = .Tuple2Wrapper(tuple1CLValue, tuple2CLValue)
                let tupleType2Serialization = try CLTypeSerializeHelper.CLValueSerialize(input: tupleType2)
                XCTAssert(tupleType2Serialization == "0d00000048656c6c6f2c20576f726c642101000000")
            } catch {
                
            }
            //test for Tuple3
            do {
                let tupleType3 : CLValueWrapper = .Tuple3Wrapper(tuple2CLValue, tuple1CLValue, tuple3CLValue)
                let tupleType3Serialization = try CLTypeSerializeHelper.CLValueSerialize(input: tupleType3)
                XCTAssert(tupleType3Serialization == "010000000d00000048656c6c6f2c20576f726c642101")
            } catch {
                
            }
        } catch {
            
        }
    }
}