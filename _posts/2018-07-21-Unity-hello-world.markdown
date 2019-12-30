---
layout: post
comments: true
title:  "Unity 'Hello World'"
date:   2018-07-21 10:00:00 +0200
categories: [unity, c#]
tag: [games, helloworld]
---

## Printing to console

* Create new project (set `Template` to `2D`).

* Inside `Assets` create script `hello.cs` with the following code:

``` c#
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Hello : MonoBehaviour {

    // Use this for initialization
    void Start () {
        print("Hello World");
    }
     
    // Update is called once per frame
    void Update () {
    
    }
}
```

That is:
1. right click in `Assets` area `Create > C# Script`, 
2. rename it `Hello.cs`, 
3. double click on it,
4. add `print("Hello World");` inside `Start` method,
5. save it and build it (just in case).

* Attach script `hello.cs` to `SampleScene` - `Main Camera` by drag-and-drop the script onto `Main
Camera.`

* Save Scene and run (press `>` button). 

* Switch to `Console` tab in order to see something like 
  
``` output
[13:29:19] Hello World
UnityEngine.MonoBehaviour:print(Object)
```

## Printing to Scene

In order to print inside the scene you should add a method 

``` c#
void OnGUI()
    {
        GUILayout.Label("Hello World");
    }
```
into class `Hello`. So the script `Hello.cs` should like like:

``` c#
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Hello : MonoBehaviour {

	// Use this for initialization
	void Start () {
        print("Hello World"); 		
	}
	
	// Update is called once per frame
	void Update () {
		
	}

    void OnGUI()
    {
        GUILayout.Label("Hello World");
    }
}
```

"
