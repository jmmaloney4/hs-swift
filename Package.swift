// Copyright © 2017 Jack Maloney. All Rights Reserved.
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import PackageDescription

let package = Package(
    name: "Arcanus",
    targets: [ Target(name: "Arcanus", dependencies: ["ArcanusCore"]) ],

    dependencies: [
        .Package(url: "https://github.com/jmmaloney4/Squall.git", versions: Version(1,2,3)..<Version(1,3,0)),
        .Package(url: "https://github.com/jmmaloney4/VarInt.git", "0.3.0"),
    ]
)
