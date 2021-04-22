// Copyright (c) 2011-2014 The Ignitecoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef IGNITECOIN_QT_IGNITECOINADDRESSVALIDATOR_H
#define IGNITECOIN_QT_IGNITECOINADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class IgnitecoinAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit IgnitecoinAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

/** Ignitecoin address widget validator, checks for a valid ignitecoin address.
 */
class IgnitecoinAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit IgnitecoinAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

#endif // IGNITECOIN_QT_IGNITECOINADDRESSVALIDATOR_H
