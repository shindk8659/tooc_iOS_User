/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Region : Codable {
	let area0 : Area0?
	let area1 : Area1?
	let area2 : Area2?
	let area3 : Area3?
	let area4 : Area4?

	enum CodingKeys: String, CodingKey {

		case area0 = "area0"
		case area1 = "area1"
		case area2 = "area2"
		case area3 = "area3"
		case area4 = "area4"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		area0 = try values.decodeIfPresent(Area0.self, forKey: .area0)
		area1 = try values.decodeIfPresent(Area1.self, forKey: .area1)
		area2 = try values.decodeIfPresent(Area2.self, forKey: .area2)
		area3 = try values.decodeIfPresent(Area3.self, forKey: .area3)
		area4 = try values.decodeIfPresent(Area4.self, forKey: .area4)
	}

}