    #import "BorderView.h"

    @implementation BorderView {
        NSLayoutConstraint *topConstraint;
        NSLayoutConstraint *leftConstraint;
        NSLayoutConstraint *bottomConstraint;
        NSLayoutConstraint *rightConstraint;
        UIView *_contentView;
    }

    #pragma mark - Public API

    - (UIView *)contentView {
        if (!_contentView) {
            [self createContentView];
        }
        return _contentView;
    }

    - (void)setContentView:(UIView *)contentView {
        if (_contentView) {
            [self destroyContentView];
        }
        _contentView = contentView;
        [self addSubview:contentView];
    }

    - (void)setBorderSize:(UIEdgeInsets)borderSize {
        if (!UIEdgeInsetsEqualToEdgeInsets(borderSize, _borderSize)) {
            _borderSize = borderSize;
            [self setNeedsUpdateConstraints];
            [self setNeedsDisplay];
        }
    }

    #pragma mark - UIView overrides

    - (void)drawRect:(CGRect)rect {
        CGRect bounds = self.bounds;
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:bounds];
        [path appendPath:[UIBezierPath bezierPathWithRect:UIEdgeInsetsInsetRect(bounds, self.borderSize)]];
        path.usesEvenOddFillRule = YES;
        [path addClip];
        [[UIColor redColor] setFill];
        UIRectFill(bounds);
    }

    #pragma mark - Implementation details

    -  (void)createContentView {
        _contentView = [[UIView alloc] init];
        [self addSubview:_contentView];
    }

    - (void)destroyContentView {
        [_contentView removeFromSuperview];
        _contentView = nil;
        [self removeConstraint:topConstraint];
        topConstraint = nil;
        [self removeConstraint:leftConstraint];
        leftConstraint = nil;
        [self removeConstraint:bottomConstraint];
        bottomConstraint = nil;
        [self removeConstraint:rightConstraint];
        rightConstraint = nil;
    }

    - (void)updateConstraints {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
        [super updateConstraints];
        if (!topConstraint) {
            [self createContentViewConstraints];
        }
        topConstraint.constant = _borderSize.top;
        leftConstraint.constant = _borderSize.left;
        bottomConstraint.constant = -_borderSize.bottom;
        rightConstraint.constant = -_borderSize.right;
    }

    - (void)createContentViewConstraints {
        topConstraint = [self constrainContentViewAttribute:NSLayoutAttributeTop];
        leftConstraint = [self constrainContentViewAttribute:NSLayoutAttributeLeft];
        bottomConstraint = [self constrainContentViewAttribute:NSLayoutAttributeBottom];
        rightConstraint = [self constrainContentViewAttribute:NSLayoutAttributeRight];
    }

    - (NSLayoutConstraint *)constrainContentViewAttribute:(NSLayoutAttribute)attribute {
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:_contentView attribute:attribute relatedBy:NSLayoutRelationEqual toItem:self attribute:attribute multiplier:1 constant:0];
        [self addConstraint:constraint];
        return constraint;
    }

    @end
