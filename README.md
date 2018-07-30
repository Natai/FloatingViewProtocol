# 特性

1. 支持拖动、自动吸附、吸附后部分隐藏
2. 支持自定义可吸附的 edges 
3. 支持自定义水平和纵向吸附的优先级
4. 支持自定义开始吸附的最小距离
5. 支持自定义悬浮视图可到达区域 
6. 支持自定义添加到`UIView`子类或者本库提供的`keyWindow`上

# 环境要求

- iOS 8.0+
- Swift 4.1

# 安装

## Cocoapods

在`Podfile`添加:

```
pod 'FloatingViewProtocol'
```

# 使用

## 简单运用

1. 遵守`FloatingViewProtocol`协议

2. 实现`component`属性

3. 调用`addFloatingPanGestureRecognir()`方法添加拖动手势

此时悬浮视图已经支持拖动和自动吸附。水平默认超过屏幕中点，纵向默认距离屏幕边缘小于 100 时即可吸附。

## 自定义

在简单运用的基础上，可在悬浮视图中重写各种属性：

```swift
class FloatingView: UIView, FloatingViewProtocol {
    /// 是否可以拖拽
    var isDraggable = true
    /// 是否自动吸附
    var isAutoAdsorb = true
    /// 可自动吸附的方向
    var adsorbableEdges: FloatingAdsorbableEdges = [.left, .right]
    /// 水平方向吸附和垂直方向吸附的优先级
    var adsorbPriority: FloatingAdsorbPriority = .equal
    /// 吸附动画时间
    var adsorbAnimationDuration: TimeInterval = 0.35
    /// 停止拖拽后，最小距离 floatingEdge 边缘多少可以自动吸附
    var minAdsorbableSpacings: UIEdgeInsets = UIEdgeInsets(top: 100, left: 50, bottom: 100, right: 50)
    /// 吸附在边缘后是否自动地部分隐藏
    var isAutoPartiallyHide = true
    /// 隐藏的百分比
    var partiallyHidePercent: CGFloat  = 0.3
    /// 部分隐藏动画时长
    var partiallyHideAnimationDuration: TimeInterval = 0.35
    /// 悬浮视图可到达区域，距离父视图各边的缩进
    var floatingEdgeInsets: UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
}
```

此外当悬浮视图已经添加到父视图后，还可以对悬浮视图对象的属性直接赋值修改以上特性。

## 父视图

悬浮视图可以直接添加到普通的`UIView`子类中，也可以添加到新建的`keyWindow`中。

添加到普通`UIView`子类：

```swift
navigationController?.view.addSubview(floatingView)
```

添加到新建的`keyWindow`：

```swift
floatingView.makeFloatingWindowKeyAndVisible()
```

对于直接添加到`keyWindow`中的悬浮视图，可以动态更改`keyWindow`根视图的状态栏样式：

```swift
floatingView.updateFloatingWindowStatusBarStyle(to: default)
```

# 代理

在悬浮视图开始拖动、结束拖动、拖动中和完成部分隐藏动画时，分别有以下代理方法：

```swift
func floatingViewDidBeginDragging(panGestureRecognizer: UIPanGestureRecognizer)
func floatingViewDidEndDragging(panGestureRecognizer: UIPanGestureRecognizer)
func floatingViewDidMove(panGestureRecognizer: UIPanGestureRecognizer)
func floatingViewFinishedPartiallyHideAnimation()
```

