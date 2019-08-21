// # CM3D2.SlowAnimation.Plugin
//
// CM3D2 および COM3D2 で Shift 押下中のアニメーションをスローモーションにします。

/*
MIT License

Copyright (c) 2019 Cello

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/


using System;
using System.Reflection;

using UnityEngine;
using UnityInjector;
using UnityInjector.Attributes;


using CM3D2.SlowAnimation.Plugin;
[assembly: AssemblyProduct(SlowAnimation.PluginName)]
[assembly: AssemblyTitle(SlowAnimation.PluginName + " " + SlowAnimation.PluginVersion)]
[assembly: AssemblyFileVersion(SlowAnimation.PluginVersion)]
[assembly: AssemblyCopyright("Copyright 2019 Cello")]


namespace CM3D2.SlowAnimation.Plugin
{
    [PluginName(SlowAnimation.PluginName)]
    [PluginVersion(SlowAnimation.PluginVersion)]
    [PluginFilter("COM3D2x64")]
    [PluginFilter("COM3D2OHx64")]
    [PluginFilter("CM3D2x64")]
    [PluginFilter("CM3D2OHx64")]
    [PluginFilter("CM3D2x86")]
    [PluginFilter("CM3D2OHx86")]
    public sealed class SlowAnimation : PluginBase
    {
        internal const string PluginName = "CM3D2.SlowAnimation.Plugin";
        internal const string PluginVersion = "1.0.0.0";

        public float TimeScale { get; set; }
        public float FixedDeltaTime
        {
            get { return 0.02f * TimeScale; }
        }

        public SlowAnimation()
        {
            TimeScale = 0.1f;
        }

        void Update()
        {
            if (Input.GetKey(KeyCode.LeftShift))
            {
                if (Time.timeScale != TimeScale)
                {
                    Time.timeScale = TimeScale;
                    Time.fixedDeltaTime = FixedDeltaTime;
                }
            }
            else if (Time.timeScale != 1.0f)
            {
                Time.timeScale = 1.0f;
                Time.fixedDeltaTime = FixedDeltaTime;
            }
        }
    }
}
